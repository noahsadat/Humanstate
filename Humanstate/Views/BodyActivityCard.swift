import SwiftUI

struct BodyActivityCard: View {
    let activity: String
    let completed: Int
    let total: Int
    @State private var isPlanning: Bool = false
    @State private var selectedExercise: String = "Push Ups"
    @State private var selectedAmount: Int = 0
    @State private var pendingChanges: [String: Int] = [:]
    @Binding var tasks: [BodyTask]
    @Binding var availableExercises: [BodyExercise]
    
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
                    exercisePlanningView
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
    
    private var exercisePlanningView: some View {
        VStack(spacing: 10) {
            GeometryReader { geometry in
                VStack(spacing: 5) {
                    HStack(spacing: 0) {
                        Text("Exercise")
                            .frame(width: geometry.size.width * 0.65, alignment: .center)
                        Text("Daily Goal")
                            .frame(width: geometry.size.width * 0.35, alignment: .center)
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    
                    HStack(spacing: 0) {
                        Picker("Exercise", selection: $selectedExercise) {
                            ForEach(availableExercises, id: \.name) { exercise in
                                Text(exercise.name).tag(exercise.name)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: geometry.size.width * 0.65)
                        .clipped()
                        .onChange(of: selectedExercise) { oldValue, newValue in
                            updateSelectedAmount()
                        }
                        
                        Picker("Amount", selection: $selectedAmount) {
                            ForEach(0...20, id: \.self) { i in
                                Text("\(i * 10)").tag(i * 10)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: geometry.size.width * 0.35)
                        .clipped()
                        .onChange(of: selectedAmount) { oldValue, newValue in
                            pendingChanges[selectedExercise] = newValue
                        }
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
        if let amount = pendingChanges[selectedExercise] {
            selectedAmount = amount
        } else if let task = tasks.first(where: { $0.name == selectedExercise }) {
            selectedAmount = task.dailyGoal
        } else {
            selectedAmount = 0
        }
    }
    
    private func saveAllTasks() {
        for (exerciseName, amount) in pendingChanges {
            if let index = tasks.firstIndex(where: { $0.name == exerciseName }) {
                if amount == 0 {
                    tasks.remove(at: index)
                } else {
                    tasks[index].dailyGoal = amount
                }
            } else if amount > 0 {
                let newTask = BodyTask(name: exerciseName, dailyGoal: amount)
                tasks.append(newTask)
            }
        }
        pendingChanges.removeAll()
    }
}
