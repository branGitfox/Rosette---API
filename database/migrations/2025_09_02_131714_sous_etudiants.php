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
        Schema::create('sousetudiants', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('cl_id');
            $table->unsignedBigInteger('sa_id');
            $table->unsignedBigInteger('ac_id');
            $table->unsignedBigInteger('et_id');
            $table->foreign('cl_id')->references('id')->on('classes');
            $table->foreign('et_id')->references('id')->on('etudiants');
            $table->foreign('sa_id')->references('id')->on('salles');
            $table->foreign('ac_id')->references('id')->on('acs');
            $table->decimal('note1')->nullable();
            $table->decimal('note2')->nullable();
            $table->decimal('note3')->nullable();
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
