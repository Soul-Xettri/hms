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
        Schema::create('adminacc', function (Blueprint $table) {
            $table->id('a_id');
            $table->string('fname',60);
            $table->string('lname',60);
            $table->text('address')->nullable();
            $table->text('city')->nullable();
            $table->string('pnm')->nullable();
            $table->enum('gender',["M", "F" ,"O"])->nullable();
            $table->integer('age')->nullable();
            $table->foreignId('id')->constrained('users')->onDelete('cascade');
            $table->string('email',100)->unique();
       
            $table->string('password');
            $table->string('role',20)->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('adminacc');
    }
};
