<?php

namespace Database\Seeders;

use App\Models\Categories;
use App\Models\Days;
use App\Models\Hours;
use App\Models\LessonDetail;
use App\Models\Lessons;
use App\Models\LessonTimes;
use App\Models\SoldDetails;
use App\Models\SoldLesson;
use App\Models\User;
use Database\Factories\SoldDetailsFactory;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $userCreate =[
            'name' => 'Admin Admin',
            'email' => 'admin@admin.com',
            'teacher'=>'1',
            'email_verified_at' => now(),
            'password' => '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', // password
            'remember_token' => Str::random(10),
        ];
        $studCreate =[
            'name' => 'Student Student',
            'email' => 'student@student.com',
            'teacher'=>'0',
            'email_verified_at' => now(),
            'password' => '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', // password
            'remember_token' => Str::random(10),
        ];
        User::create($userCreate);
        User::create($studCreate);
         User::factory(10)->create();
         Categories::factory(10)->create();
         Lessons::factory(10)->create();
         LessonDetail::factory(10)->create();
         SoldDetails::factory(10)->create();
    }
}
