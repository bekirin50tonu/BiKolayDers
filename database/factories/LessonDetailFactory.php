<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class LessonDetailFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        $time = array();

        for ($i = 0; $i < 24; $i++) {
            if ($i <= 9) {
                $data = '0' . $i . ':00';
                array_push($time,$data );
            } else {
                $data = $i . ':00';
                array_push($time,$data );
            }
        }
        return [
            'hour' => $time[array_rand($time)],
            'lesson_id' => rand(1, 9),
        ];
    }
}
