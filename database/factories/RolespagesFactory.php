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
            [
                'role_id' => 1,
                'page_id' => 1,
            ],
            [
                'role_id' => 1,
                'page_id' => 2,
            ],
            [
                'role_id' => 1,
                'page_id' => 4,
            ],
            [
                'role_id' => 1,
                'page_id' => 5,
            ],
            [
                'role_id' => 1,
                'page_id' => 6,
            ],
            [
                'role_id' => 1,
                'page_id' => 7,
            ],
            [
                'role_id' => 1,
                'page_id' => 8,
            ],
            [
                'role_id' => 1,
                'page_id' => 9,
            ],
            [
                'role_id' => 1,
                'page_id' => 10,
            ],
            [
                'role_id' => 1,
                'page_id' => 11,
            ],
        ];
    }
}
