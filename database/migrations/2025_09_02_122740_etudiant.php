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
        Schema::create('etudiants', function (Blueprint $table) {
            $table->id();
            $table->string('nom');
            $table->string('prenom');
            $table->boolean('sexe');
            $table->string('dateNaissance');
            $table->string('lieuNaissance');
            $table->string('adresse');
            $table->string('nomPere')->nullable()->default('');
            $table->string('nomMere')->nullable()->default('');
            $table->string('telephonePere')->nullable()->default('');
            $table->string('telephoneMere')->nullable()->default('');
            $table->string('prenomMere')->nullable()->default('');
            $table->string('prenomPere')->nullable()->default('');
            $table->string('nomTuteur')->nullable()->default('');
            $table->string('prenomTuteur')->nullable()->default('');
            $table->string('telephoneTuteur')->nullable()->default('');
            $table->string('matricule')->default('');
            $table->string('ecole')->nullable()->default('');
            $table->string('photo');
            $table->timestamps();
            $table->boolean('enfantProf');
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
