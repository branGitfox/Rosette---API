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
        Schema::table('schools', function (Blueprint $table) {

            $table->string('owner')->default('')->nullable();
            $table->string('telephone')->default('')->nullable();
            $table->string('email')->default('')->nullable();
            $table->string('adresse')->default('')->nullable();
            $table->string('decision')->default('')->nullable();
            $table->string('code')->default('')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('schools', function (Blueprint $table) {

        });
    }
};
