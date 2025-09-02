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
            $table->date('dateNaissance');
            $table->string('lieuNaissance');
            $table->string('adresse');
            $table->string('nomPere')->nullable();
            $table->string('nomMere')->nullable();
            $table->string('telephonePere')->nullable();
            $table->string('telephoneMere')->nullable();
            $table->string('prenomMere')->nullable();
            $table->string('prenomPere')->nullable();
            $table->string('nomTuteur')->nullable();
            $table->string('prenomTuteur')->nullable();
            $table->string('telephoneTuteur')->nullable();
            $table->string('matricule');
            $table->string('ecole');
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
