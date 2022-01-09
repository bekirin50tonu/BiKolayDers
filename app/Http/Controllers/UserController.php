<?php

namespace App\Http\Controllers;

use App\Http\Controllers\base\BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class UserController extends BaseController
{
    function register(Request $request){
        $data = $request->all();
        $rules = ['name' => 'required|min:6', 'email' => ['required', 'unique:users', 'email'], 'password' => 'required'];
        $messages = array(
            'name.required' => 'Lütfen Adınızı ve Soyadınızı Giriniz.',
            'name.min' => 'İsim 6 Karakterden Fazla Olmalıdır.',
            'email.required' => 'Lütfen E Posta Adresi Giriniz.',
            'email.unique' => 'E Posta Adresi Başkası Tarafından Alınmış!',
            'email.email' => 'Lütfen Geçerli Bir E Posta Adresi Giriniz.',
            'password.required' => 'Lütfen Parolanızı Giriniz.',
        );
        $validator = Validator::make($data, $rules, $messages);
        if ($validator->fails()) {
            $messages = $validator->messages();
            $errors = $messages->all();
            $errors = implode('\n',$errors);
            return $this->sendError($errors);
        }
        $userData = $request->all();
        $password = $userData['password'];
        $password = Hash::make($password);
        $userData['password'] = $password;

        if (\App\Models\User::create($userData)) {
            $message = $userData['name'];
            return $this->sendResponse($message);
        }
        return $this->sendError('Bir Şeyler Test Gitti, Tekrar Deneyiniz!');
    }

    function login(Request $request){
        $data = $request->all();

        $rules = ['email' => ['required', 'email'], 'password' => 'required'];
        $messages = array(
            'email.required' => 'Lütfen E Posta Adresinizi Giriniz.',
            'email.email' => 'Geçerli Bir E Posta Adresi Giriniz.',
            'password.required' => 'Lütfen Parolanızı Giriniz..',
        );

        $validator = Validator::make($data, $rules, $messages);
        if ($validator->fails()) {
            $messages = $validator->messages();
            $errors = $messages->all();
            $errors = implode('\n',$errors);
            $sendData['token'] = '';
            $sendData['name'] = '';
            return $this->sendError($errors,$sendData);
        }

        if (Auth::attempt($data)) {
            $user = Auth::user();
            $message = "User Login Successful ";
            $sendData['token'] = $request->user()->createToken('BiKolayDers')->accessToken;
            $sendData['name'] = $user->name;

            return $this->sendResponse($message,$sendData);
        }
        $sendData['token'] = '';
        $sendData['name'] = '';
        return $this->sendError('Giriş Başarısız. Lütfen E Posta Adresinizi ve Parolanızı Kontrol Ediniz.',$sendData);
    }

    function logout(Request $request){
        if (Auth::check()) {
            Auth::user()->tokens->each(function($token, $key) {
                $token->delete();
            });
            return $this->sendResponse('Logged Out');
        }
        return $this->sendError('SomeThing is Wrong!');

    }

    function user_details(){
        $user = auth('api')->user();
        return $this->sendResponse($user->name.' Ayrıntılar.',$user);
    }

    public function is_auth(){
        if (auth('api')->user()){
            return response(['success'=>true],200);
        }
        return response(['success'=>false],200);
    }
}
