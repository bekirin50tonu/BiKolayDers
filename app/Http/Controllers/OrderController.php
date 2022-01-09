<?php

namespace App\Http\Controllers;

use App\Http\Controllers\base\BaseController;
use App\Models\LessonDetail;
use App\Models\Lessons;
use Illuminate\Http\Request;

class OrderController extends BaseController
{

    // Post alarak geliyorsa $request değerini girmek zorundasın
    public function create_order(Request $request){
        $data = $request->all();

        $lesson = LessonDetail::query()->where($data)->with('parent','children')->get();

        return $this->sendResponse('ads',$lesson);

    }
}
