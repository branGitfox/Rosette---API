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
        Schema::create('kermessehistos', function (Blueprint $table) {
            $table->id();
            $table->integer('montant')->default(0);
            $table->foreignId('kr_id')->constrained('studentkermesses')->cascadeOnDelete();
            $table->enum('type', ['complet', 'avance', 'rembourse'])->default('complet');
            $table->timestamps();
            $table->integer('reste')->default(0);
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
