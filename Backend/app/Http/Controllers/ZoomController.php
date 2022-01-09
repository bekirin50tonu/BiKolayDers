<?php

namespace App\Http\Controllers;

use App\Http\Controllers\base\BaseController;
use App\Traits\ZoomMeetingTrait;
use Illuminate\Http\Request;

class ZoomController extends BaseController
{
    use ZoomMeetingTrait;


    const MEETING_TYPE_INSTANT = 1;
    const MEETING_TYPE_SCHEDULE = 2;
    const MEETING_TYPE_RECURRING = 3;
    const MEETING_TYPE_FIXED_RECURRING_FIXED = 8;

    public function show(Request $request)
    {
        $id = $request->id;

        $response = $this->get($id);

        return response($response,200);
    }

    public function store(Request $request)
    {
        $response = $this->create($request->all());

        return response($response,200);
    }

    public function change(Request $request)
    {
        $id = $request->id;
        $data = $request->all();
        unset($data['id']);
        $response = $this->update($id, $data);
        return response($response,200);

    }

    public function destroy(Request $request)
    {
        $id = $request->id;
        $response = $this->delete($id);

        return response($response,200);
    }
}
