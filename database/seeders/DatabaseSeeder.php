<?php

namespace Database\Seeders;

use App\Models\Pages;
use App\Models\Roles;
use App\Models\Rolespages;
use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;


use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
//         User::factory(10)->create();

//        User::factory()->create([
//            'name' => 'Test User',
//            'email' => 'test@example.com',
//        ]);

        Roles::insert([
            ['role_name' => 'Admin'],
        ]);


        Pages::insert([
            ['id' => 1, 'page_name' => 'Gestion Droits', 'page_path' => '/home/StudentsDroit'],
            ['id' => 2, 'page_name' => 'Gestion Ecolages', 'page_path' => '/home/ecolagestudents'],
            ['id' => 3, 'page_name' => 'Gestion Notes', 'page_path' => '/home/notemanagements'],
            ['id' => 4, 'page_name' => 'information Etudiants', 'page_path' => '/home/StudentsInfo'],
            ['id' => 5, 'page_name' => 'Dashboard', 'page_path' => '/home'],
            ['id' => 6, 'page_name' => 'Gestion Kermesses', 'page_path' => '/home/StudentsKermess'],
            ['id' => 7, 'page_name' => 'Etudiants inactifs', 'page_path' => '/home/studentsInactif'],
            ['id' => 8, 'page_name' => 'Paramètres', 'page_path' => '/home/parametre'],
            ['id' => 9, 'page_name' => 'Information Employés', 'page_path' => '/home/EmployeInfo'],
            ['id' => 10, 'page_name' => 'Suivi Employés', 'page_path' => '/home/Employersuivi'],
            ['id' => 11, 'page_name' => "Historiques D'activités", 'page_path' => '/home/Historique'],
        ]);


        Rolespages::insert([
            ['role_id' => 1, 'page_id' => 1],
            ['role_id' => 1, 'page_id' => 2],
            ['role_id' => 1, 'page_id' => 4],
            ['role_id' => 1, 'page_id' => 5],
            ['role_id' => 1, 'page_id' => 6],
            ['role_id' => 1, 'page_id' => 7],
            ['role_id' => 1, 'page_id' => 8],
            ['role_id' => 1, 'page_id' => 9],
            ['role_id' => 1, 'page_id' => 10],
            ['role_id' => 1, 'page_id' => 11],
        ]);
    }
}
