<?php

use App\Http\Controllers\LessonController as LessonController;
use App\Http\Controllers\OrderController as OrderController;
use App\Http\Controllers\UserController as UserController;
use App\Http\Controllers\ZoomController as ZoomController;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth:api'])->group(function () {
    // Logout Route (delete all token keys)
    Route::post('logout', [UserController::class, 'logout']);

    // User Detail (Token Required)
    Route::get('user', [UserController::class, 'user_details']);

    // lesson crud //
    Route::prefix('lesson')->group(function () {
        Route::post('create', [LessonController::class, 'create']);
        Route::post('edit', [LessonController::class, 'edit']);
        Route::post('delete', [LessonController::class, 'destroy']);
    });
    // lesson crud //


    // All Lesson Hour Details
    Route::get('/user/lesson/hour/detail', [LessonController::class, 'get_user_lesson_hour_detail']);

    // Get Prefix
    Route::prefix('get')->group(function () {
        // Get Lesson By ID
        Route::post('lesson', [LessonController::class, 'get_lesson_by_id']);
        // Get User By ID
        Route::post('user', [LessonController::class, 'get_user_by_id']);
        // Sold Screen Lesson Details
        Route::post('lesson/detail', [LessonController::class, 'get_lesson_detail_by_id']);
        // Get Lesson Date and Hour
        Route::post('lesson/date_hour', [LessonController::class, 'get_hour_lesson_by_id_with_date']);
        // Get User Lessons
        Route::get('lessons', [LessonController::class, 'get_lessons']);
        // Get User Sold Lessons
        Route::get('lesson/teacher/sold', [LessonController::class, 'get_sold_lessons']);
        // Get User Pending Lessons
        Route::get('lesson/teacher/pending', [LessonController::class, 'get_pending_lessons']);
        // Get Lesson Hour Details
        Route::get('lesson/detail/hour', [LessonController::class, 'get_all_hour_from_lesson_by_userid']);
    });
    // Student Gets
    Route::prefix('get')->group(function (){
        // Get User All Lessons
        Route::get('lesson/student/all', [LessonController::class, 'get_student_all_lessons']);
    });

    // Set Prefix
    Route::prefix('set')->group(function () {
        // Set User Sold Lesson
        Route::post('lesson/sold', [LessonController::class, 'set_sold_lesson']);
        // Set User Pending Lesson
        Route::post('lesson/pending', [LessonController::class, 'set_pending_lesson']);
        // Set User Available Lesson
        Route::post('lesson/available', [LessonController::class, 'set_available_lesson']);
        // Set User Disabled Lesson
        Route::post('lesson/disabled', [LessonController::class, 'set_disabled_lesson']);
    });

    // Search Prefix
    Route::prefix('search')->group(function () {
        Route::post('lesson', [LessonController::class, 'search_lesson']);
        Route::post('user', [LessonController::class, 'search_user']);
        Route::post('category', [LessonController::class, 'search_category']);
    });

    // MIDDLEWARE OF TEACHER
    Route::middleware('teacher')->group(function () {
        Route::post('user/lessons', [LessonController::class, 'get_user_lessons']);

    });
});

Route::middleware('guest')->group(function () {

    Route::get('is_auth', [UserController::class, 'is_auth']);
    Route::post('register', [UserController::class, 'register']);
    Route::post('login', [UserController::class, 'login']);

    //Zoom Prefixs
    Route::prefix('zoom')->group(function () {
        Route::get('get_room', [ZoomController::class, 'get']);
        Route::post('create', [ZoomController::class, 'store']);
        Route::post('update', [ZoomController::class, 'change']);
        Route::post('delete', [ZoomController::class, 'destroy']);
    });

    Route::get('deneme', [OrderController::class, 'create_order']);

});


