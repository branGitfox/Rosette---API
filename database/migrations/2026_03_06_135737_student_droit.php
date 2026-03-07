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
        Schema::create('studentdroits', function (Blueprint $table) {
            $table->id();
            $table->foreignId('se_id')->constrained('sousetudiants')->cascadeOnDelete();
            $table->timestamps();
            $table->integer('reste')->default(0);
            $table->boolean('payed')->default(false);
            $table->integer('paid')->default(0);
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
