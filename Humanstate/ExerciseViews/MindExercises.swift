import Foundation

struct MindExercise: Identifiable {
    let id = UUID()
    let name: String
    let countingUnit: String
    let countingStep: Int
    var dailyGoal: Int?
}

struct MindExercises {
    static let all: [MindExercise] = [
        MindExercise(name: "Meditation", countingUnit: "minutes", countingStep: 5),
        MindExercise(name: "Journaling", countingUnit: "minutes", countingStep: 5),
        MindExercise(name: "Deep Breathing", countingUnit: "minutes", countingStep: 1),
        MindExercise(name: "Visualization", countingUnit: "minutes", countingStep: 5),
        MindExercise(name: "Gratitude Practice", countingUnit: "items", countingStep: 1),
        MindExercise(name: "Mindful Walking", countingUnit: "minutes", countingStep: 5),
        MindExercise(name: "Progressive Muscle Relaxation", countingUnit: "minutes", countingStep: 5),
        MindExercise(name: "Affirmations", countingUnit: "repetitions", countingStep: 5),
        MindExercise(name: "Mindful Eating", countingUnit: "minutes", countingStep: 5),
        MindExercise(name: "Body Scan", countingUnit: "minutes", countingStep: 5)
    ]
}
