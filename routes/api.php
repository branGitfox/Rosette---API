<?php

use App\Http\Controllers\AcController;
use App\Http\Controllers\AdmissionsController;
use App\Http\Controllers\ClassesController;
use App\Http\Controllers\EtudiantsController;
use App\Http\Controllers\SallesController;
use App\Http\Controllers\SousetudiantsController;
use App\Http\Controllers\UsersController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');


//ROUTE POUR UTILISATEUR
Route::post('/users-creation', [UsersController::class, 'creation']);
Route::post('/users-connexion', [UsersController::class, 'connexion']);


//ROUTE POUR ANNEE SCOLAIRE
Route::post('/ac-creation', [AcController::class, 'create']);
Route::get('/ac-list', [AcController::class, 'list']);
Route::get('/ac-list-no-month', [AcController::class, 'listAnnee']);
Route::delete('/ac-delete/{id}', [AcController::class, 'delete']);


//ROUTE POUR CLASSES
Route::post('/classe-creation', [ClassesController::class, 'create']);
Route::get('/classe-list', [ClassesController::class, 'list']);
Route::delete('/classe-delete/{id}', [ClassesController::class, 'delete']);

//Route POUR SALLE
Route::post('salle-creation', [SallesController::class, 'create']);
Route::get('salle-list', [SallesController::class, 'list']);
Route::delete('salle-delete/{id}', [SallesController::class, 'delete']);

//ROUTE POUR REGLAGE D"ADMISSION
Route::post('admission-creation', [AdmissionsController::class, 'create']);
Route::get('admission-list', [AdmissionsController::class, 'list']);
Route::delete('admission-delete/{id}', [AdmissionsController::class, 'delete']);
//SOUSETUDIANTS
Route::put('etudiant-note/{id}', [SousetudiantsController::class, 'update_note']);

//ROUTE POUR ETUDIANTs
Route::post('etudiant-creation', [EtudiantsController::class, 'inscription']);
Route::get('etudiant-matricule', [EtudiantsController::class, 'matricule']);
Route::get('etudiant-list', [EtudiantsController::class, 'list']);
Route::get('etudiant-list_note', [EtudiantsController::class, 'list_note']);

Route::get('etudiant/{id}', [EtudiantsController::class, 'etudiant']);
Route::post('etudiant/{id}', [EtudiantsController::class, 'updates']);
Route::delete('etudiant/{id}', [EtudiantsController::class, 'deletes']);

