<?php

use App\Http\Controllers\AcController;
use App\Http\Controllers\AdmissionsController;
use App\Http\Controllers\ClassesController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\DepensesController;
use App\Http\Controllers\DepensesMoisController;
use App\Http\Controllers\DroitsController;
use App\Http\Controllers\EcolageController;
use App\Http\Controllers\EtudiantsController;
use App\Http\Controllers\KermessesController;
use App\Http\Controllers\MacController;
use App\Http\Controllers\MoisecolageController;
use App\Http\Controllers\ProfessionsController;
use App\Http\Controllers\RevenusMoisController;
use App\Http\Controllers\SallesController;
use App\Http\Controllers\SousetudiantsController;
use App\Http\Controllers\UsersController;
use App\Http\Controllers\WorkersController;
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
Route::get('/classe-list_year/{id}', [ClassesController::class, 'list_year']);
Route::delete('/classe-delete/{id}', [ClassesController::class, 'delete']);

//Route POUR SALLE
Route::post('salle-creation', [SallesController::class, 'create']);
Route::get('salle-list', [SallesController::class, 'list']);
Route::get('/salle-list_year/{id}', [SallesController::class, 'list_year']);
Route::delete('salle-delete/{id}', [SallesController::class, 'delete']);
Route::get('salle-list_last', [SallesController::class, 'list_last']);

//ROUTE POUR REGLAGE D"ADMISSION
Route::post('admission-creation', [AdmissionsController::class, 'create']);
Route::get('admission-list', [AdmissionsController::class, 'list']);
Route::delete('admission-delete/{id}', [AdmissionsController::class, 'delete']);
//SOUSETUDIANTS
Route::put('etudiant-note/{id}', [SousetudiantsController::class, 'update_note']);
Route::post('etudiant-recreation', [EtudiantsController::class, 'reinscriptions']);
Route::put('etudiant-suspendre/{id}', [EtudiantsController::class, 'suspendre']);

//ROUTE POUR ETUDIANTs
Route::post('etudiant-creation', [EtudiantsController::class, 'inscription']);
Route::get('etudiant-matricule', [EtudiantsController::class, 'matricule']);
Route::get('etudiant-list', [EtudiantsController::class, 'list']);
Route::get('etudiant-list_note', [EtudiantsController::class, 'list_note']);
Route::get('etudiant/{id}', [EtudiantsController::class, 'etudiant']);
Route::post('etudiant/{id}', [EtudiantsController::class, 'updates']);
Route::delete('etudiant/{id}', [EtudiantsController::class, 'deletes']);
Route::get('etudiant-list_ecolage', [EtudiantsController::class, 'list_ecolage']);
// ROUTE POUR MOIS ECOLAGE
Route::get('mac-list_year/{id}', [MacController::class, 'list_year']);
Route::get('etudiant-count', [EtudiantsController::class, 'count']);

//ROUTE POUR ECOLAGE
Route::put('ecolage-pay/{id}', [EcolageController::class, 'pay']);
Route::get('ecolage-solde', [EcolageController::class, 'total']);

//ROUTE POUR DROITS
Route::get('droit-solde', [DroitsController::class, 'total']);
//ROUTE POUR KERMESSE
Route::get('kermesse-solde', [KermessesController::class, 'total']);

//ROUTE POUR EMPLOYEE
Route::post('worker-creation', [WorkersController::class, 'create']);
Route::post('worker-update/{id}', [WorkersController::class, 'update']);
Route::get('worker-list', [WorkersController::class, 'list']);
Route::get('worker/{id}', [WorkersController::class, 'worker']);
Route::delete('worker/{id}', [WorkersController::class, 'delete']);
Route::get('worker-count', [WorkersController::class, 'count']);


//ROUTE POUR PROFESSION
Route::post('profession-creation', [ProfessionsController::class, 'create']);
Route::get('profession-list', [ProfessionsController::class, 'list']);

//ROUTE POUR VISUALISATION DATAPIE

Route::get('datapie', [EtudiantsController::class, 'effectif']);

//TEST CASE POUR REVENUS ET DEPENSES AFIN DE SIMULER LE GRAPH BAR
//REVENUSPAR MOIS
Route::post('revenu', [RevenusMoisController::class, 'create']);


//DEPENSES PAR MOIS
Route::post('depense', [DepensesMoisController::class, 'create']);


//DASHBOARD
Route::get('databar', [DashboardController::class, 'getBarData']);
Route::get('flux', [DashboardController::class, 'getFlux']);


