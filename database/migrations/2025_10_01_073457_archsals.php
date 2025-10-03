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
        Schema::create('archsals', function (Blueprint $table) {
                $table->id();
                $table->integer('montant');
                $table->string('mois');
                $table->boolean('type');
                $table->unsignedBigInteger('ac_id');
                $table->unsignedBigInteger('w_id');
                $table->foreign('ac_id')->references('id')->on('acs')->cascadeOnDelete();
                $table->foreign('w_id')->references('id')->on('workers')->cascadeOnDelete();
                $table->text('motif');
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
