
// BodyExercises.swift
import Foundation

struct BodyExercise: Identifiable {
    let id = UUID()
    let name: String
    var dailyGoal: Int?
}

struct BodyExercises {
    static let all: [BodyExercise] = [
        BodyExercise(name: "Push Ups"),
        BodyExercise(name: "Sit Ups"),
        BodyExercise(name: "Squats"),
        BodyExercise(name: "Lunges"),
        BodyExercise(name: "Plank"),
        BodyExercise(name: "Tricep Dips"),
        BodyExercise(name: "Russian Twists"),
        BodyExercise(name: "Mountain Climbers"),
        BodyExercise(name: "Leg Raises"),
        BodyExercise(name: "Jumping Jacks"),
        BodyExercise(name: "High Knees"),
        BodyExercise(name: "Glute Bridges"),
        BodyExercise(name: "Crunches"),
        BodyExercise(name: "Burpees"),
        BodyExercise(name: "Butt Kicks"),
        BodyExercise(name: "Standing Calf Raises"),
        BodyExercise(name: "Wall Sits"),
        BodyExercise(name: "Supermans"),
        BodyExercise(name: "Donkey Kicks"),
        BodyExercise(name: "Side Plank"),
        BodyExercise(name: "Hip Thrusts"),
        BodyExercise(name: "Inchworms"),
        BodyExercise(name: "Skater Hops"),
        BodyExercise(name: "Step-Ups"),
        BodyExercise(name: "Chair Pose (Yoga)"),
        BodyExercise(name: "Side Lunges"),
        BodyExercise(name: "Jump Squats"),
        BodyExercise(name: "Frog Jumps"),
        BodyExercise(name: "Reverse Crunches"),
    ]
}
