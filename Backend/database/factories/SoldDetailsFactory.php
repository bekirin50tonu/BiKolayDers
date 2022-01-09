<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class SoldDetailsFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'detail_id'=>rand(1,6),

        ];
    }
}
