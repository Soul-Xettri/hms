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
        Schema::create('nurseacc', function (Blueprint $table) {
            $table->id('nr_id');
            $table->string('fname',60);
            $table->string('lname',60);
            $table->text('address');
            $table->text('city');
            $table->string('pnm');
            $table->enum('gender',["M", "F" ,"O"]);
            $table->integer('age');
            $table->string('email',100)->unique();
            $table->string('password');
            $table->string('img1');
            $table->string('role',20)->nullable();
            $table->rememberToken();   
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('nurseacc');
    }
};
