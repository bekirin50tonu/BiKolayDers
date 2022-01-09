<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Lessons extends Model
{
    use HasFactory;


    protected $fillable = ['name', 'price', 'category_id', 'user_id'];

    protected $hidden = ['category_id','user_id'];


    public function category(): \Illuminate\Database\Eloquent\Relations\HasOne
    {
        return $this->hasOne(Categories::class, 'id', 'category_id')->select(['id','name']);
    }

    public function user(): \Illuminate\Database\Eloquent\Relations\HasOne
    {
        return $this->hasOne(User::class, 'id', 'user_id')->select(['id','name','email','teacher']);
    }

    public function detail(){
        return $this->hasMany(LessonDetail::class,'lesson_id','id')->select(['lesson_id','id','status','hour']);
    }



}
