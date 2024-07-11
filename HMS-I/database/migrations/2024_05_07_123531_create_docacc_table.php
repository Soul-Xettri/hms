<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('docacc', function (Blueprint $table) {
            $table->id('dc_id');
            $table->string('fname',60);
            $table->string('lname',60);
            $table->text('address')->nullable();
            $table->text('city')->nullable();
            $table->string('pnm')->nullable();
            $table->enum('gender',["M", "F" ,"O"])->nullable();
            $table->integer('age')->nullable();
            $table->string('email',100)->unique();
            $table->string('password');
            $table->string('img1')->nullable();
            $table->string('role',20)->nullable();
            //$table->foreign('dpt_id')->references('dpt_id')->on('departmenttyp')->onDelete('cascade');
            $table->foreignId('dpt_id')->nullable()->constrained('departmenttyp')->onDelete('cascade');
            $table->text('speciality')->nullable();
            $table->text('exp')->nullable();
            $table->foreignId('id')->constrained('users')->onDelete('cascade');
            $table->text('qual')->nullable();//qualifiaction
            $table-> time('starttime')->default( '09:00:00');
            $table->time('endtime')->default('17:00:00');
            $table->rememberToken();   
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('docacc');
    }
};
