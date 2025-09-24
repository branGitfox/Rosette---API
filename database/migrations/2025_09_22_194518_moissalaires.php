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
        Schema::create('moissalaires', function (Blueprint $table) {
            $table->id();
            $table->string('mois');
            $table->unsignedBigInteger('ac_id');
            $table->boolean('payé')->default(false);
            $table->unsignedBigInteger('w_id');
            $table->foreign('w_id')->references('id')->on('workers')->cascadeOnDelete();
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
