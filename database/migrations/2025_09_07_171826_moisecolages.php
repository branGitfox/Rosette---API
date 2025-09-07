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
        Schema::create('moisecolages', function (Blueprint $table) {
            $table->id();
            $table->string('mois');
            $table->boolean('payé')->default(false);
            $table->timestamps();
            $table->unsignedBigInteger('et_id');
            $table->foreign('et_id')->references('id')->on('etudiants')->cascadeOnDelete();
            $table->unsignedBigInteger('ac_id');
            $table->foreign('ac_id')->references('id')->on('acs')->cascadeOnDelete();
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
