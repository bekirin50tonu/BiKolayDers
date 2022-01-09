<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LessonDetail extends Model
{
    use HasFactory;


    protected $fillable = ['hour','lesson_id','status'];

    protected $hidden = ['created_at','updated_at','user_id','lesson_id'];


    public function parent(): \Illuminate\Database\Eloquent\Relations\HasOne
    {
        return $this->hasOne(Lessons::class,'id','lesson_id');
    }
    public function children(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(SoldDetails::class,'detail_id','id');
    }
}
