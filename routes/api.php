<?php

use App\Http\Controllers\AcController;
use App\Http\Controllers\AdmissionsController;
use App\Http\Controllers\ClassesController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\DepensesController;
use App\Http\Controllers\DepensesMoisController;
use App\Http\Controllers\DomainesController;
use App\Http\Controllers\DroitsController;
use App\Http\Controllers\EcolageController;
use App\Http\Controllers\EtudiantsController;
use App\Http\Controllers\IdentifysController;
use App\Http\Controllers\KermessesController;
use App\Http\Controllers\MacController;
use App\Http\Controllers\MoisecolageController;
use App\Http\Controllers\NifsController;
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
Route::post('/users-creation', [UsersController::class, 'creation'])->middleware('auth:sanctum');
Route::post('/users-connexion', [UsersController::class, 'connexion']);


//ROUTE POUR ANNEE SCOLAIRE
Route::post('/ac-creation', [AcController::class, 'create'])->middleware('auth:sanctum');
Route::get('/ac-list', [AcController::class, 'list'])->middleware('auth:sanctum');
Route::get('/ac-list-no-month', [AcController::class, 'listAnnee'])->middleware('auth:sanctum');
Route::delete('/ac-delete/{id}', [AcController::class, 'delete'])->middleware('auth:sanctum');


//ROUTE POUR CLASSES
Route::post('/classe-creation', [ClassesController::class, 'create'])->middleware('auth:sanctum');
Route::get('/classe-list', [ClassesController::class, 'list'])->middleware('auth:sanctum');
Route::get('/classe-list_year/{id}', [ClassesController::class, 'list_year'])->middleware('auth:sanctum');
Route::delete('/classe-delete/{id}', [ClassesController::class, 'delete'])->middleware('auth:sanctum');

//Route POUR SALLE
Route::post('salle-creation', [SallesController::class, 'create'])->middleware('auth:sanctum');
Route::get('salle-list', [SallesController::class, 'list'])->middleware('auth:sanctum');
Route::get('/salle-list_year/{id}', [SallesController::class, 'list_year'])->middleware('auth:sanctum');
Route::delete('salle-delete/{id}', [SallesController::class, 'delete'])->middleware('auth:sanctum');
Route::get('salle-list_last', [SallesController::class, 'list_last'])->middleware('auth:sanctum');

//ROUTE POUR REGLAGE D"ADMISSION
Route::post('admission-creation', [AdmissionsController::class, 'create'])->middleware('auth:sanctum');
Route::get('admission-list', [AdmissionsController::class, 'list']);
Route::delete('admission-delete/{id}', [AdmissionsController::class, 'delete'])->middleware('auth:sanctum');
//SOUSETUDIANTS
Route::put('etudiant-note/{id}', [SousetudiantsController::class, 'update_note'])->middleware('auth:sanctum');
Route::post('etudiant-recreation', [EtudiantsController::class, 'reinscriptions'])->middleware('auth:sanctum');
Route::put('etudiant-suspendre/{id}', [EtudiantsController::class, 'suspendre'])->middleware('auth:sanctum');

//ROUTE POUR ETUDIANTs
Route::post('etudiant-creation', [EtudiantsController::class, 'inscription'])->middleware('auth:sanctum');
Route::get('etudiant-matricule', [EtudiantsController::class, 'matricule'])->middleware('auth:sanctum');
Route::get('etudiant-list', [EtudiantsController::class, 'list'])->middleware('auth:sanctum');
Route::get('etudiant-list_note', [EtudiantsController::class, 'list_note'])->middleware('auth:sanctum');
Route::get('etudiant/{id}', [EtudiantsController::class, 'etudiant'])->middleware('auth:sanctum');
Route::post('etudiant/{id}', [EtudiantsController::class, 'updates'])->middleware('auth:sanctum');
Route::delete('etudiant/{id}', [EtudiantsController::class, 'deletes']);
Route::get('etudiant-list_ecolage', [EtudiantsController::class, 'list_ecolage'])->middleware('auth:sanctum');
// ROUTE POUR MOIS ECOLAGE
Route::get('mac-list_year/{id}', [MacController::class, 'list_year'])->middleware('auth:sanctum');
Route::get('etudiant-count', [EtudiantsController::class, 'count'])->middleware('auth:sanctum');

//ROUTE POUR ECOLAGE
Route::put('ecolage-pay/{id}', [EcolageController::class, 'pay'])->middleware('auth:sanctum');
Route::get('ecolage-solde', [EcolageController::class, 'total'])->middleware('auth:sanctum');

//ROUTE POUR DROITS
Route::get('droit-solde', [DroitsController::class, 'total'])->middleware('auth:sanctum');
//ROUTE POUR KERMESSE
Route::get('kermesse-solde', [KermessesController::class, 'total'])->middleware('auth:sanctum');

//ROUTE POUR EMPLOYEE
Route::post('worker-creation', [WorkersController::class, 'create'])->middleware('auth:sanctum');
Route::post('worker-update/{id}', [WorkersController::class, 'update'])->middleware('auth:sanctum');
Route::get('worker-list', [WorkersController::class, 'list'])->middleware('auth:sanctum');
Route::get('worker/{id}', [WorkersController::class, 'worker'])->middleware('auth:sanctum');
Route::delete('worker/{id}', [WorkersController::class, 'delete'])->middleware('auth:sanctum');
Route::get('worker-count', [WorkersController::class, 'count'])->middleware('auth:sanctum');
Route::post('worker-pay', [\App\Http\Controllers\MoissalairesController::class, 'pay'])->middleware('auth:sanctum');
Route::put('worker-status/{id}', [WorkersController::class, 'status'])->middleware('auth:sanctum');


//ROUTE POUR PROFESSION
Route::post('profession-creation', [ProfessionsController::class, 'create'])->middleware('auth:sanctum');
Route::get('profession-list', [ProfessionsController::class, 'list'])->middleware('auth:sanctum');
Route::delete('profession/{id}', [ProfessionsController::class, 'deletes'])->middleware('auth:sanctum');

//ROUTE POUR VISUALISATION DATAPIE

Route::get('datapie', [EtudiantsController::class, 'effectif'])->middleware('auth:sanctum');

//TEST CASE POUR REVENUS ET DEPENSES AFIN DE SIMULER LE GRAPH BAR
//REVENUSPAR MOIS
Route::post('revenu', [RevenusMoisController::class, 'create'])->middleware('auth:sanctum');


//DEPENSES PAR MOIS
Route::post('depense', [DepensesMoisController::class, 'create'])->middleware('auth:sanctum');


//DASHBOARD
Route::get('databar', [DashboardController::class, 'getBarData'])->middleware('auth:sanctum');
Route::get('flux', [DashboardController::class, 'getFlux'])->middleware('auth:sanctum');
Route::post('operation-plus',[DashboardController::class, 'plus'])->middleware('auth:sanctum');
//INFORMATION CONCERNANT L'ECOLE
Route::post('nif', [NifsController::class, 'create'])->middleware('auth:sanctum');
Route::get('nif-1', [NifsController::class, 'list'])->middleware('auth:sanctum');
Route::delete('nif/{id}', [NifsController::class, 'deletes'])->middleware('auth:sanctum');
Route::get('identifys-1', [IdentifysController::class, 'list'])->middleware('auth:sanctum');
Route::delete('identify/{id}', [IdentifysController::class, 'deletes'])->middleware('auth:sanctum');
Route::post('identify', [IdentifysController::class, 'create'])->middleware('auth:sanctum');

//MATIERE

Route::post('domaines', [DomainesController::class, 'create'])->middleware('auth:sanctum');
Route::get('domaines', [DomainesController::class, 'list'])->middleware('auth:sanctum');
Route::delete('domaines/{id}', [DomainesController::class, 'deletes'])->middleware('auth:sanctum');
Route::get('export', [\App\Http\Controllers\Backup::class, 'backupDatabase'])->middleware('auth:sanctum');
Route::post('import', [\App\Http\Controllers\Backup::class, 'restoreDatabase'])->middleware('auth:sanctum');

//MOISDALAIRES
Route::get('moissalaires/{id}', [\App\Http\Controllers\MoissalairesController::class, 'moissalaires'])->middleware('auth:sanctum');

//ARCHIVE SALAIRES
Route::get('archives/{id}', [\App\Http\Controllers\MoissalairesController::class, 'archives'])->middleware('auth:sanctum');

//ROUTE POUR CONGE
Route::post('conge', [\App\Http\Controllers\ArchcongesController::class, 'create'])->middleware('auth:sanctum');
Route::get('conge-auto-stop', [WorkersController::class, 'auto_stop_conge'])->middleware('auth:sanctum');

//ARCHIVE CONGE
Route::get('conge/{id}', [\App\Http\Controllers\ArchcongesController::class, 'archives'])->middleware('auth:sanctum');
Route::delete('conge/{id}', [\App\Http\Controllers\ArchcongesController::class, 'deletes'])->middleware('auth:sanctum');

//ROUTE POUR IDENTIFYS
Route::get('identifys', function () {
    return \App\Models\Identifys::latest()->first()->ident;
});

//ROUTE POUR IDENTIFYS
Route::get('nif', function () {
    return \App\Models\Nifs::latest()->first()->nif;
});

Route::get('logout', function(Request $request) {
    $request->user()->tokens()->delete();
    return response()->json(['message' => 'Vous etes deconnecté']);
})->middleware('auth:sanctum');


Route::get('/user-auto', function() {
    if(!\App\Models\User::where('email', 'rosette@gmail.com')->exists()){
        \App\Models\User::create([
            'email' => 'rosette@gmail.com',
            'role' => 'directeur',
            'password' => 'rosette2025',
            'name' => 'Rosette',
            'firstname' => 'Rosette',
        ]);
    }


});
