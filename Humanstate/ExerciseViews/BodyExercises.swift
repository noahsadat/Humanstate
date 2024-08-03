import Foundation

struct BodyExercise: Identifiable {
    let id = UUID()
    let name: String
    let countingUnit: String
    let countingStep: Int
    var dailyGoal: Int?
}

struct BodyExercises {
    static let all: [BodyExercise] = [
        BodyExercise(name: "Push Ups", countingUnit: "reps", countingStep: 10),
        BodyExercise(name: "Sit Ups", countingUnit: "reps", countingStep: 5),
        BodyExercise(name: "Squats", countingUnit: "reps", countingStep: 5),
        BodyExercise(name: "Lunges", countingUnit: "reps", countingStep: 2),
        BodyExercise(name: "Plank", countingUnit: "seconds", countingStep: 10),
        BodyExercise(name: "Tricep Dips", countingUnit: "reps", countingStep: 2),
        BodyExercise(name: "Russian Twists", countingUnit: "reps", countingStep: 5),
        BodyExercise(name: "Mountain Climbers", countingUnit: "reps", countingStep: 5),
        BodyExercise(name: "Leg Raises", countingUnit: "reps", countingStep: 2),
        BodyExercise(name: "Jumping Jacks", countingUnit: "reps", countingStep: 10),
        BodyExercise(name: "High Knees", countingUnit: "seconds", countingStep: 5),
        BodyExercise(name: "Glute Bridges", countingUnit: "reps", countingStep: 5),
        BodyExercise(name: "Crunches", countingUnit: "reps", countingStep: 5),
        BodyExercise(name: "Burpees", countingUnit: "reps", countingStep: 1),
        BodyExercise(name: "Butt Kicks", countingUnit: "seconds", countingStep: 5),
        BodyExercise(name: "Standing Calf Raises", countingUnit: "reps", countingStep: 5),
        BodyExercise(name: "Wall Sits", countingUnit: "seconds", countingStep: 10),
        BodyExercise(name: "Supermans", countingUnit: "reps", countingStep: 2),
        BodyExercise(name: "Donkey Kicks", countingUnit: "reps", countingStep: 2),
        BodyExercise(name: "Side Plank", countingUnit: "seconds", countingStep: 5),
        BodyExercise(name: "Hip Thrusts", countingUnit: "reps", countingStep: 5),
        BodyExercise(name: "Inchworms", countingUnit: "reps", countingStep: 1),
        BodyExercise(name: "Skater Hops", countingUnit: "reps", countingStep: 2),
        BodyExercise(name: "Step-Ups", countingUnit: "reps", countingStep: 2),
        BodyExercise(name: "Chair Pose (Yoga)", countingUnit: "seconds", countingStep: 5),
        BodyExercise(name: "Side Lunges", countingUnit: "reps", countingStep: 2),
        BodyExercise(name: "Jump Squats", countingUnit: "reps", countingStep: 2),
        BodyExercise(name: "Frog Jumps", countingUnit: "reps", countingStep: 1),
        BodyExercise(name: "Reverse Crunches", countingUnit: "reps", countingStep: 2),
    ]
}
