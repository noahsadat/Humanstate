import SwiftUI
import SwiftData

struct MindActivityCard: View {
    let activity: String
    let completed: Int
    let total: Int
    @State private var isPlanning: Bool = false
    @State private var selectedMindExercise: String = "Meditation"
    @State private var selectedAmount: Int = 5
    @State private var pendingChanges: [String: Int] = [:]
    @Query var tasks: [MindTask]
    @Binding var availableExercises: [MindExercise]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(activity)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(isPlanning ? "Cancel" : "Plan") {
                    withAnimation {
                        if isPlanning {
                            pendingChanges.removeAll()
                        }
                        isPlanning.toggle()
                    }
                }
                .foregroundColor(.blue)
            }
            
            if !isPlanning {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        if activity == "Exercise" {
                            Text("\(completedTasks) of \(tasks.count) completed")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            ProgressView(value: Double(completedTasks), total: Double(max(tasks.count, 1)))
                                .progressViewStyle(LinearProgressViewStyle())
                                .frame(width: 120)
                        } else {
                            Text("\(total - completed) to go")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            ProgressView(value: Double(completed), total: Double(total))
                                .progressViewStyle(LinearProgressViewStyle())
                                .frame(width: 120)
                        }
                    }
                    Spacer()
                    if activity == "Exercise" {
                        Text("\(completedTasks)/\(tasks.count)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    } else {
                        Text("\(completed)/\(total)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                }
            } else {
                if activity == "Exercise" {
                    mindExercisePlanningView
                } else {
                    Text("Planning for \(activity) is not implemented yet.")
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        .animation(.spring(), value: isPlanning)
    }
    
    private var completedTasks: Int {
        tasks.filter { $0.completed }.count
    }
    
    private var mindExercisePlanningView: some View {
        VStack(spacing: 10) {
            GeometryReader { geometry in
                VStack(spacing: 5) {
                    HStack(spacing: 0) {
                        Text("Mind Exercise")
                            .frame(width: geometry.size.width * 0.5, alignment: .center)
                        Text("Daily Goal")
                            .frame(width: geometry.size.width * 0.25, alignment: .center)
                        Text("Unit")
                            .frame(width: geometry.size.width * 0.25, alignment: .center)
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    
                    HStack(spacing: 0) {
                        Picker("Mind Exercise", selection: $selectedMindExercise) {
                            ForEach(availableExercises, id: \.name) { exercise in
                                Text(exercise.name).tag(exercise.name)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: geometry.size.width * 0.5)
                        .clipped()
                        .onChange(of: selectedMindExercise) { oldValue, newValue in
                            updateSelectedAmount()
                        }
                        
                        Picker("Amount", selection: $selectedAmount) {
                            ForEach(0...20, id: \.self) { i in
                                let exercise = availableExercises.first(where: { $0.name == selectedMindExercise })!
                                Text("\(i * exercise.countingStep)").tag(i * exercise.countingStep)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: geometry.size.width * 0.25)
                        .clipped()
                        .onChange(of: selectedAmount) { oldValue, newValue in
                            pendingChanges[selectedMindExercise] = newValue
                        }
                        
                        Text(availableExercises.first(where: { $0.name == selectedMindExercise })?.countingUnit ?? "")
                            .frame(width: geometry.size.width * 0.25, alignment: .center)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(height: 120)
            
            Button("Save") {
                saveAllTasks()
                withAnimation {
                    isPlanning = false
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .frame(maxWidth: .infinity)
        }
    }
    
    private func updateSelectedAmount() {
        if let amount = pendingChanges[selectedMindExercise] {
            selectedAmount = amount
        } else if let task = tasks.first(where: { $0.name == selectedMindExercise }) {
            selectedAmount = task.dailyGoal
        } else {
            selectedAmount = 0
        }
    }
    
    private func saveAllTasks() {
        for (exerciseName, amount) in pendingChanges {
            if let existingTask = tasks.first(where: { $0.name == exerciseName }) {
                if amount == 0 {
                    modelContext.delete(existingTask)
                } else {
                    existingTask.dailyGoal = amount
                }
            } else if amount > 0 {
                let newTask = MindTask(name: exerciseName, dailyGoal: amount)
                modelContext.insert(newTask)
            }
        }
        pendingChanges.removeAll()
    }
}
