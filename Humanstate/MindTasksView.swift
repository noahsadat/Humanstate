import SwiftUI
import SwiftData

struct MindTasksView: View {
    @Query private var tasks: [MindTask]
    @Binding var availableExercises: [MindExercise]
    @State private var currentTaskIndex: Int = 0
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack(spacing: 15) {
            // Header
            HStack {
                Text("Daily Tasks")
                    .font(.headline)
                Spacer()
                Text("\(currentTaskIndex + 1)/\(incompleteTasks.count)")
                Spacer()
            }
            .padding(.bottom, 10)
            
            // Task Content
            if !incompleteTasks.isEmpty {
                MindTaskView(task: incompleteTasks[currentTaskIndex], availableExercises: availableExercises, onTaskCompleted: handleTaskCompletion)
            } else {
                VStack {
                    Text("All tasks completed!")
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            }
            
            // Pagination Dots
            if incompleteTasks.count > 1 {
                HStack(spacing: 5) {
                    ForEach(0..<incompleteTasks.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentTaskIndex ? Color.blue : Color.gray)
                            .frame(width: 8, height: 8)
                    }
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < 0 && currentTaskIndex < incompleteTasks.count - 1 {
                        currentTaskIndex += 1
                    } else if value.translation.width > 0 && currentTaskIndex > 0 {
                        currentTaskIndex -= 1
                    }
                }
        )
    }
    
    private var incompleteTasks: [MindTask] {
        tasks.filter { !$0.completed }
    }
    
    private func handleTaskCompletion(taskId: UUID) {
        if let index = tasks.firstIndex(where: { $0.id == taskId }) {
            tasks[index].completed = true
            tasks[index].count = 0
            tasks[index].lastModifiedAt = Date()
            
            do {
                try modelContext.save()
            } catch {
                print("Failed to save task completion: \(error)")
            }
            
            // Move to the next incomplete task or reset to the first one if all are completed
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                if currentTaskIndex >= incompleteTasks.count - 1 {
                    currentTaskIndex = 0
                }
            }
        }
    }
}

struct MindTaskView: View {
    @Bindable var task: MindTask
    let availableExercises: [MindExercise]
    var onTaskCompleted: (UUID) -> Void
    @State private var showingWellDone: Bool = false
    @Environment(\.modelContext) private var modelContext
    
    private var exercise: MindExercise? {
        availableExercises.first(where: { $0.name == task.name })
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text(task.name)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.bottom, 5)
            
            HStack {
                Button(action: {
                    let step = availableExercises.first(where: { $0.name == task.name })?.countingStep ?? 1
                    task.count = max(0, task.count - step)
                    saveChanges()
                }) {
                    Image(systemName: "minus.circle")
                        .imageScale(.large)
                        .foregroundColor(Color(UIColor.systemRed))
                }
                
                Spacer()
                
                if showingWellDone {
                    Text("Well done!")
                        .font(.headline)
                        .foregroundColor(.green)
                        .transition(.opacity)
                } else {
                    VStack {
                        Text(String(format: "%02d/%02d", task.count, task.dailyGoal))
                            .font(.system(size: 40, weight: .bold, design: .default))
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .foregroundColor(.primary)
                        Text(availableExercises.first(where: { $0.name == task.name })?.countingUnit ?? "")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    if !task.completed {
                        let step = availableExercises.first(where: { $0.name == task.name })?.countingStep ?? 1
                        task.count = min(task.dailyGoal, task.count + step)
                        saveChanges()
                        checkCompletion()
                    }
                }) {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                        .foregroundColor(Color(UIColor.systemGreen))
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(20)
        .shadow(radius: 10)
    }
    
    private func checkCompletion() {
        if task.count >= task.dailyGoal {
            withAnimation {
                showingWellDone = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    showingWellDone = false
                    task.completed = true
                }
                saveChanges()
                onTaskCompleted(task.id)
            }
        }
    }
    
    private func saveChanges() {
        task.lastModifiedAt = Date()
        do {
            try modelContext.save()
        } catch {
            print("Failed to save task changes: \(error)")
        }
    }
}
