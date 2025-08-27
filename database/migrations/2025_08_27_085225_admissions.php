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
        Schema::create("admissions", function (Blueprint $table) {
           $table->id();
           $table->string('note');
           $table->unsignedBigInteger('ac_id');
           $table->foreign('ac_id')->references('id')->on('acs')->cascadeOnDelete();
           $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
    }
};
