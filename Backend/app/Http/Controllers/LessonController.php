<?php

namespace App\Http\Controllers;

use App\Http\Controllers\base\BaseController;
use App\Models\Categories;
use App\Models\Days;
use App\Models\Hours;
use App\Models\LessonDetail;
use App\Models\Lessons;
use App\Models\LessonTimes;
use App\Models\SoldDetails;
use App\Models\SoldLesson;
use App\Models\User;
use Exception;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use phpDocumentor\Reflection\DocBlock\Tags\Author;

class LessonController extends BaseController
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    //LINE: search area
    public function search_lesson(Request $request)
    {
        $search = $request->search;
        $user = auth('api')->user();
        $data = Lessons::query()->where('name', 'like', '%' . $search . '%')->with(['user', 'category','detail:lesson_id,hour'])
            ->select('user_id','category_id','id','name','price')->get();
        $message = 'Search ' . $search . ' Lessons';
        return $this->sendResponse($message, $data);
    }

    public function search_user(Request $request)
    {
        $search = $request->search;
        $user = auth('api')->user();
        $data = User::query()->where('name', 'like', '%' . $search . '%')->get();
        $message = 'Search ' . $search . ' User';
        return $this->sendResponse($message, $data);
    }

    public function search_category(Request $request)
    {
        $search = $request->search;
        $user = auth('api')->user();
        $data = Categories::query()->where('name', 'like', '%' . $search . '%')->get();
        $message = 'Search ' . $search . ' Category';
        return $this->sendResponse($message, $data);
    }
    //LINE: search area

    // TODO: Error Handler
    public function get_lesson_by_id(request $request)
    {
        $id = $request->id;

        $lesson = Lessons::query()->where('id', '=', $id)->select('id', 'name', 'price', 'category_id', 'user_id')
            ->with(['user', 'category'])->get();

        return $this->sendResponse('Get Lesson By ID', $lesson);
    }

    // TODO: Error Handler
    public function get_user_by_id(Request $request)
    {
        $id = $request->id;

        $user = User::query()->where('id', '=', $id)->select(['id', 'name', 'email', 'teacher'])->get();

        return $this->sendResponse('Get User By ID', $user);
    }

    // Get Lessons <teacher>
    public function get_lessons()
    {
        $user = auth('api')->user();

        $lessons = Lessons::query()->whereRelation('detail', 'user_id', '=', $user->id)
            ->with(['detail:id,hour,lesson_id'])->select(['id', 'name', 'price'])->get();

        return $this->sendResponse('????retmen B??t??n Dersleri ve Detaylar??', $lessons);
    }

    // Get Sold Lessons <teacher>
    //tarih, saat, kim ald??, ders ismi
    // TODO: pendingler de geliyor gelmemeli!!
    // TODO:: ????renci sat??n al??nan ve bekleyenleri listeleyecek rota haz??rla!!
    public function get_sold_lessons()
    {
        $user = auth('api')->user();

        $lessons = SoldDetails::query()
            ->where('status','=','sold')
            ->whereRelation('parent.parent','user_id','=',$user->id)
            ->select('date','status','user_id','detail_id')
            ->with('user:id,name','parent:id,hour,lesson_id','parent.parent:id,name,category_id','parent.parent.category:id,name')
            ->get();

        return $this->sendResponse('Sat??n Al??nan Dersler.', $lessons);
    }

    // Get Sold Lessons <student>
    public function get_student_all_lessons()
    {
        $user = auth('api')->user();

        $lessons = SoldDetails::query()
            ->where('status','!=','disabled')
            ->where('user_id','=',$user->id)
            ->select('date','status','user_id','detail_id')
            ->with('user:id,name','parent:id,hour,lesson_id','parent.parent:id,name,category_id,user_id','parent.parent.category:id,name','parent.parent.user:id,name')
            ->get();

        return $this->sendResponse('Sat??n Al??nan Dersler.', $lessons);
    }

    // Get Pending Lessons <teacher>
    public function get_pending_lessons()
    {
        $user = auth('api')->user();

        $lessons = SoldDetails::query()
            ->where('status','=','pending')
            ->whereRelation('parent.parent','user_id','=',$user->id)
            ->select('date','status','user_id','detail_id')
            ->with('user:id,name','parent:id,hour,lesson_id','parent.parent:id,name,category_id','parent.parent.category:id,name')
            ->get();

        return $this->sendResponse('Onay Bekleyen Dersler.', $lessons);
    }


    // Set Pending Lesson <student>
    public function set_pending_lesson(Request $request)
    {
        $userID = auth('api')->user()->id;
        $id = $request->id;
        $create['date'] = $request->date;
        $create['user_id'] = $userID;
        $create['status'] = 'pending';


        foreach ($request->hours as $hour){
            $details = LessonDetail::query()->whereRelation('parent','id',$id)->where('hour','=',$hour)->with('children')->first();
            if (empty($details)|| empty($details['children'])) return $this->sendError('Verilen Bilgilerle Alakal?? Bir ??ey Bulunamad??.');
            foreach ($details['children'] as $detail){
                if ($detail['date'] == $create['date']) return $this->sendError('Hata! Belirtilen Tarih ve Saat Dolu.');
            }
            $create['detail_id'] = $details->id;
            $status = SoldDetails::query()->create($create);
        }
        return $this->sendResponse('Sat??n Al??m Olu??turuldu. Onaylanmas?? Bekleniyor.');
    }

    // Set Sold Lesson <teacher>
    public function set_sold_lesson(Request $request)
    {
        $id = $request->id;
        $create['status'] = 'sold';
        $sold_id = null;
        $update = 0;

        foreach ($request->hours as $hour) {
            $details = LessonDetail::query()->whereRelation('parent','id',$id)->where('hour','=',$hour)->with('children')->first();
            if (empty($details)|| empty($details['children'])) return $this->sendError('Verilen Bilgilerle Alakal?? Bir ??ey Bulunamad??.');
            foreach ($details['children'] as $detail){
                if ($detail['status'] != "pending") return $this->sendError('Beklemede Olmayan Dersi Onaylayamazs??n??z.');
                $sold_id = $detail['id'];
            }
            $update = SoldDetails::query()->find($sold_id)->update($create);
        }
        return $update == 1 ? $this->sendResponse('Sat??n Al??m Onaylanm????t??r.') : $this->sendError('Hata!');
    }

    // Set Available Lesson <teacher>
    public function set_available_lesson(Request $request)
    {
        $id = $request->id;
        $create['user_id'] = null;
        $create['date'] = null;
        $create['status'] = 'available';

        foreach ($request->hours as $hour) {
            $details = LessonDetail::query()->whereRelation('parent','id',$id)->where('hour','=',$hour)->with('children')->first();
            if (empty($details)|| empty($details['children'])) return $this->sendError('Verilen Bilgilerle Alakal?? Bir ??ey Bulunamad??.');
            foreach ($details['children'] as $detail){
                if ($detail['status'] == "available") return $this->sendError('Ders Zaten A????k.');
                $sold_id = $detail['id'];
            }
            $update = SoldDetails::query()->find($sold_id)->update($create);
        }
        return $update == 1 ? $this->sendResponse('Ders Saati Bo??a ????km????t??r.') : $this->sendError('Hata!');
    }

    // Set Disabled Lesson <teacher>
    public function set_disabled_lesson(Request $request)
    {
        $id = $request->id;
        $create['status'] = 'disabled';
        foreach ($request->hours as $hour) {
            $update = LessonDetail::query()->whereRelation('parent', 'id', '=', $id)->where('hour', 'LIKE', '%' . $hour . '%')
                ->update($create);
        }
        return $update == 1 ? $this->sendResponse('Set Sold Lesson') : $this->sendError('Hata!');
    }

    //
    public function get_user_lesson_hour_detail(){
        $user = auth('api')->user();

        $lesson = LessonDetail::query()->whereRelation('parent','user_id','=',$user->id)->select('lesson_id as id','hour','status','date')->get();

        return $this->sendResponse('Ders Bilgileri',$lesson);
    }

    public function get_lesson_detail_by_id(Request $request)
    {
        $id = $request->id;
        $user = auth('api')->user();

        $lessons = LessonDetail::query()->whereRelation('parent','user_id', $user->id)->whereRelation('parent','id',$id)
            ->select('hour','date','status')
            ->get();

        return $this->sendResponse('User Lesson Time Detail', $lessons);
    }


    public function get_hour_lesson_by_id_with_date(Request $request){
        $id = $request->id;
        $date = $request->date;

        $detail = LessonDetail::query()->whereRelation('parent','id',$id)->whereRelation('children','date',$date)
            ->whereRelation('children','status','!=','available')
            ->select('hour')->get()->pluck('hour');

        return $this->sendResponse('Tarihi ve Id Verilen Dersin Detayl?? Saatleri',$detail);
    }

    public function get_all_hour_from_lesson_by_userid(){
        $user = auth('api')->user();

        $hours = LessonDetail::query()->whereRelation('parent','user_id',$user->id)->select('hour')->get()->pluck('hour');

        return $this->sendResponse('B??t??n Ders Saatleri Getirdi.',$hours);
    }

    // TODO: Eklemelerde Hata Var D??zeltilecek.
    public function create(Request $request)
    {
        $data = $request->all();
        $user = auth('api')->user();

        // validations

        $rules = ['name' => ['required', 'min:6'], 'category' => ['required'], 'price' => ['required', 'min:2'],
            'hours' => ['array','required']];
        $messages = array(
            'name.required' => 'L??tfen Ders Ad??n?? Giriniz.',
            'name.min' => 'Ders Ad?? 6 Karakterden Fazla Olmal??d??r.',
            'category.required' => 'L??tfen Kategori Ad??n?? Giriniz.',
            'price.required' => 'L??tfen Ders ??cretini Giriniz.',
            'price.min' => '??cret, Minimum 10 Lira Olmal??d??r.',
            'hours.required' => 'L??tfen Eklemek ??stedi??iniz G??nleri Se??iniz.',
            'hours.array' => 'L??tfen Liste Halinde Giriniz Se??iniz.',
        );
        $validator = \Illuminate\Support\Facades\Validator::make($data, $rules, $messages);
        if ($validator->fails()) {
            $messages = $validator->messages();
            $errors = $messages->all();
            $errors = implode('\n', $errors);
            return $this->sendError($errors);
        }
//        return $this->sendResponse('asdas',$validator->validate());
        // validation

        //Add Lesson
        $user = auth('api')->user();
        $lesson['user_id'] = $user->id;
        $lesson['name'] = $data['name'];
        $lesson['price'] = $data['price'];
        $category_name['name'] = $data['category'];
        try {

            $category = Categories::query()->where('name', 'LIKE', '%' . $category_name['name'] . '%')->first();
            if ($category == null) {
                $lesson['category_id'] = Categories::query()->create($category_name)->id;
            } else {
                $lesson['category_id'] = $category->id;
            }
            $lesson = Lessons::query()->create($lesson);
            // lesson created //

            // Lesson Detail create //
            $lesson_id = $lesson->id;
            $hours = $data['hours'];

            foreach ($hours as $hour) {

                $c_hour['lesson_id'] = $lesson_id;
                $c_hour['hour']=$hour;
                $lesson_detail = LessonDetail::create($c_hour);
            }
            return $this->sendResponse('Ders Ba??ar??yla Olu??turuldu.');
        } catch (\Throwable $e) {

            return $this->sendError("{$e->getLine()}");
        }
    }

    //Edit Lesson Function
    public function edit(Request $request)
    {
        try {
            $update = null;
            $data = $request->all();
            $id = $data['id'];

            $lesson = Lessons::query()->find($id);

            if (empty($lesson)) {
                return $this->sendError('B??yle Bir Ders Veritaban??nda Bulunmamaktad??r!');
            }

            $user = auth('api')->user();
            if ($lesson->user_id != $user->id) {
                return $this->sendError('Bu Derse Sahip De??ilsiniz!');
            }

            if (isset($data['name'])) {
                $update['name'] = $data['name'];
            }
            if (isset($data['price'])) {
                $update['price'] = $data['price'];
            }
            if (isset($data['category']) && !empty($data['category'])) {
                $category_create['name'] = $data['category'];
                $category_id = Categories::query()->where('name', 'LIKE', '%' . $data['category'] . '%')->first()->id
                    ?? Categories::create($category_create)->id;
                $update['category_id'] = $category_id;
            }
            if (isset($data['hours'])) {
                $lesson_details = $lesson->query()->whereId($id)->with('detail')->has('detail')->get()->pluck('detail')[0];
                if (empty($lesson_details)) return $this->sendError('De??i??tirilecek Detayl?? Veri Bulunmamaktad??r!');
                $hours = $data['hours'];
                foreach ($lesson_details as $detail) {
                    if ($detail['status'] == 'sold' || $detail['status'] == 'pending')
                        return $this->sendError('Sat??n Al??nan Veya Bekleyen Dersler De??i??tirilemez!');
                    $time = explode(':',$detail['hour']);
                    $time = $time[0].":".$time[1];
                    if(!in_array($time,$hours)){
                        LessonDetail::query()->where('id','=',$detail['id'])->update(['status'=>'disabled']);
                    }
                }
                foreach ($hours as $hour) {
                    $create['hour'] = $hour['hour'];
                    $create['lesson_id'] = $id;
                    LessonDetail::query()->create($create);
                }
            }
            if (!$lesson->update($update)) return $this->sendError('G??ncellerken Hata Olu??tu');

            return $this->sendResponse('Updated Lesson');

        } catch (QueryException $e) {
            return $this->sendError('Veritaban??nda Hata Bulundu!', $e->getMessage());
        }
    }

    // Delete Lesson Function
    public function destroy(Request $request)
    {
        // Lessons::all(); // b??t??n verileri al??r
        // Lessons::where()->first(); // Dictionary - Buldu??u ilk veriyi getirir.
        // Lessons::where()->get(); // Bu i??leme uyan her ??eyi getirir ve bir dizi verir.
        try {
            $id = $request->id;
            $user = auth('api')->user();
            $lesson = Lessons::query()->where('id','=',$id)->first();
            if (!$lesson->exists()) {
                return $this->sendError('B??yle Bir Ders Bulunmamaktad??r.');
            }
            if ($lesson->user_id != $user->id) {
                return $this->sendError('Bu Ders Sana Ait De??il!');
            }
            $success = $lesson->delete();
            return $success ? $this->sendResponse('Ders Kodu ' . $id . ' Olan Ders Ba??ar??yla Silindi!')
                : $this->sendError('Ders Kodu '.$id. ' Olan Dersi Silme ????lemi Ba??ar??s??z!');
        } catch (\Throwable $e) {
            return $this->sendError($e->getMessage());
        }
    }

    // Get User Lesson Detail
    public function get_user_lessons()
    {
        $user = auth('api')->user();

        $lessons = Lessons::query()->where('user_id','=', $user->id)->with(['category', 'detail', 'user'])->get();

        return $this->sendResponse('Get Lessons By User.', $lessons);


    }

}
