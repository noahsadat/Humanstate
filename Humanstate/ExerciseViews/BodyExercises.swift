
// BodyExercises.swift
import Foundation

struct BodyExercise: Identifiable {
    let id = UUID()
    let name: String
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
    ]
}
