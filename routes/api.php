<?php

use App\Http\Controllers\AcController;
use App\Http\Controllers\ClassesController;
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
