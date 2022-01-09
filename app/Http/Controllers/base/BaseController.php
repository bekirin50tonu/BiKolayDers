<?php

namespace App\Http\Controllers\base;

use App\Http\Controllers\Controller;

class BaseController extends Controller
{

    // send datas
    function sendResponse($message, $data = [], $headers = [])
    {
        $response = $data == [] ? $response = [
            'success' => true,
            'message' => $message
        ] : [
            'success' => true,
            'data' => $data,
            'message' => $message
        ];


        return response($response, 200, $headers);
    }


    //send errors
    function sendError($message, $data = [], $headers = [])
    {
        $response = [
            'success' => false,
            'message' => $message
        ];

        return response($response, 200, $headers);
    }
}
