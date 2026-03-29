<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Pages>
 */
class PagesFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            [
                'page_name' => 'Gestion Droits',
                'page_path' => '/home/StudentsDroit',
            ],
            [
                'page_name' => 'Gestion Ecolages',
                'page_path' => '/home/ecolagestudents',
            ],
            [
                'page_name' => 'Gestion Notes',
                'page_path' => '/home/notemanagements',
            ],
            [
                'page_name' => 'information Etudiants',
                'page_path' => '/home/StudentsInfo',
            ],
            [
                'page_name' => 'Dashboard',
                'page_path' => '/home',
            ],
            [
                'page_name' => 'Gestion Kermesses',
                'page_path' => '/home/StudentsKermess',
            ],
            [
                'page_name' => 'Etudiants inactifs',
                'page_path' => '/home/studentsInactif',
            ],
            [
                'page_name' => 'Paramètres',
                'page_path' => '/home/parametre',
            ],
            [
                'page_name' => 'Information Employés',
                'page_path' => '/home/EmployeInfo',
            ],
            [
                'page_name' => 'Suivi Employés',
                'page_path' => '/home/Employersuivi',
            ],
            [
                'page_name' => "Historiques D'activités",
                'page_path' => '/home/Historique',
            ],
        ];
    }
}
