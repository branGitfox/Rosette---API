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
        Schema::create('moins', function (Blueprint $table) {
            $table->id();
            $table->string('motif');
            $table->integer('ecolage')->default(0);
            $table->integer('droit')->default(0);
            $table->integer('kermesse')->default(0);
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
