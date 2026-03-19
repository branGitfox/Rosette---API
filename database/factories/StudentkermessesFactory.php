<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Studentkermesses>
 */
class StudentkermessesFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'se_id' => 2, 'reste' => 4000, 'payed' => 0, 'paid'=>0
        ];
    }
}
