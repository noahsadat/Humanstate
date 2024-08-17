import SwiftUI
import SwiftData

struct AllTasksView: View {
    @Query private var bodyTasks: [BodyTask]
    @Query private var mindTasks: [MindTask]
    @State private var selectedTaskType: TaskType = .body
    @Binding var availableBodyExercises: [BodyExercise]
    @Binding var availableMindExercises: [MindExercise]
    @State private var currentBodyTaskIndex: Int = 0
    @State private var currentMindTaskIndex: Int = 0
    @Environment(\.modelContext) private var modelContext
    
    enum TaskType: String, CaseIterable {
        case body = "Body"
        case mind = "Mind"
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Picker("Task Type", selection: $selectedTaskType) {
                ForEach(TaskType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            if selectedTaskType == .body {
                if let currentBodyTask = incompleteTasks(for: bodyTasks).first {
                    BodyTaskView(task: currentBodyTask, availableExercises: availableBodyExercises, onTaskCompleted: handleBodyTaskCompletion)
                } else {
                    Text("All body tasks completed!")
                        .foregroundColor(.secondary)
                }
            } else {
                if let currentMindTask = incompleteTasks(for: mindTasks).first {
                    MindTaskView(task: currentMindTask, availableExercises: availableMindExercises, onTaskCompleted: handleMindTaskCompletion)
                } else {
                    Text("All mind tasks completed!")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
    
    private func incompleteTasks<T: TaskProtocol>(for tasks: [T]) -> [T] {
        tasks.filter { !$0.completed }
    }
    
    private func handleBodyTaskCompletion(taskId: UUID) {
        if let index = bodyTasks.firstIndex(where: { $0.id == taskId }) {
            bodyTasks[index].completed = true
            bodyTasks[index].count = 0
            bodyTasks[index].lastModifiedAt = Date()
            bodyTasks[index].lastCompletionDate = Date()
            
            do {
                try modelContext.save()
            } catch {
                print("Failed to save body task completion: \(error)")
            }
        }
    }
    
    private func handleMindTaskCompletion(taskId: UUID) {
        if let index = mindTasks.firstIndex(where: { $0.id == taskId }) {
            mindTasks[index].completed = true
            mindTasks[index].count = 0
            mindTasks[index].lastModifiedAt = Date()
            mindTasks[index].lastCompletionDate = Date()
            
            do {
                try modelContext.save()
            } catch {
                print("Failed to save mind task completion: \(error)")
            }
        }
    }
}
