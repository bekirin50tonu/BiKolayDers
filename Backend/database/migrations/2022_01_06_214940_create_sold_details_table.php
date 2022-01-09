<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSoldDetailsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('sold_details', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('detail_id');
            $table->date('date')->nullable();
            $table->unsignedBigInteger('user_id')->nullable();
            $table->enum('status',['available','sold','pending','disabled'])->default('pending');
            $table->foreign('detail_id')->references('id')->on('lesson_details')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('sold_details');
    }
}
