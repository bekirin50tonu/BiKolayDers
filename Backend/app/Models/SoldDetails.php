<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SoldDetails extends Model
{
    use HasFactory;


    protected $fillable = ['detail_id','user_id','date','status'];

    protected $hidden = ['created_at','updated_at','detail_id','user_id'];


public function user(){
    return $this->hasOne(User::class,'id','user_id');
}
public function parent(){
    return $this->hasOne(LessonDetail::class,'id','detail_id');
}
}
