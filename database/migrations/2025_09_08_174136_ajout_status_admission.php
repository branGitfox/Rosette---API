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
        Schema::table('sousetudiants', function (Blueprint $table) {
            $table->enum('status_admissions', ['admis', 'cours', 'redoublé', 'suspendu'])->default('cours');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('sousetudiants', function (Blueprint $table) {
            //
        });
    }
};
