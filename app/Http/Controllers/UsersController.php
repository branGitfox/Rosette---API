<?php

namespace App\Http\Controllers;

use App\Models\User;
use http\Env\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UsersController extends Controller
{

/**
POUR LA CREATION D'UN UTILISATEUR
 */
    public function creation(Request $request, AuditsController $audit ) {

        $fields = $request->validate([
            'name' => 'required|string',
            'firstname' => 'required|string',
            'email' => 'required|string|unique:users,email',
            'password' => 'required|confirmed',
            'role' => 'required',
        ], [
            'name.required' => 'Le nom est obligatoire',
            'firstname.required' => 'Le prenom est obligatoire',
            'email.required' => 'L\'email est obligatoire',
            'password.required' => 'Le mot de passe est obligatoire',
            'email.unique' => "l'email est deja prise",
            'password.confirmed' => 'Les mots de passe ne correspondent pas'
        ]);

        User::create($fields);
        $message = 'Creation d\'un administrateur';
        $audit->listen('Paramètres', $message, $request->user()->id);
        return response()->json([
            'message' => 'utilisateur creé'
        ]);
    }

    /**
            POUR LA CONNEXION D'UN UTILISATEUR
     */
    public function connexion(Request $request){
        $fields = $request->validate([
            'email' => 'required|string',
            'password' => 'required',
        ],
        [
            'email.required' => 'L\'email est obligatoire',
            'password.required' => 'Le mot de passe est obligatoire'
        ]
        );

       $userExists =  User::where('email', $fields['email'])->first();
       if(!empty($userExists) && Hash::check($fields['password'], $userExists->password)){
              $token = $userExists->createToken('email');
              return response()->json([
                  'message' => 'connexion reussie',
                  'token' => $token->plainTextToken
              ]);
       }else{
           return response()->json([
               'message' => 'invalide email ou mot de passe'
           ]);
       }
    }
}
