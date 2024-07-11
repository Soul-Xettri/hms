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
        Schema::create('appointment', function (Blueprint $table) {
            $table->id('apt_id');
            $table->date('aptdate')->nullable();
            $table->time('apttime')->nullable();
            $table->text('pst')->nullable();
            $table->text('treat')->nullable();
            $table->text('pres')->nullable();
            $table->boolean('status')->default(0)->nullable();
            $table->unsignedBigInteger('pa_id')->nullable()->constrained()->onDelete('cascade');   
            $table->foreign('pa_id')->references('pa_id')->on('patientacc');
            $table->unsignedBigInteger('dc_id')->nullable()->constrained()->onDelete('cascade');   
            $table->foreign('dc_id')->references('dc_id')->on('docacc');
            $table->timestamps();

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('appointment');
    }
};
