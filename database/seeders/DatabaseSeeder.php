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

        Roles::factory(2)->create();
        Pages::factory(5)->create();
        Rolespages::factory(2)->create();
    }
}
