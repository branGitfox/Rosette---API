<?php

namespace Database\Factories;

use App\Models\Pages;
use App\Models\Roles;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Rolespages>
 */
class RolespagesFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'role_id' => Roles::inRandomOrder()->first()->id,
            'page_id' => Pages::inRandomOrder()->first()->id
        ];
    }
}
