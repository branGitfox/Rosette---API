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
        Schema::create('droithistos', function (Blueprint $table) {
            $table->id();
            $table->integer('montant')->default(0);
            $table->foreignId('dr_id')->constrained('studentdroits')->cascadeOnDelete();
            $table->enum('type', ['complet', 'avance', 'rembourse'])->default('complet');
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
