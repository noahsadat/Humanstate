import SwiftUI

struct BodyTasksView: View {
    @Binding var tasks: [BodyTask]
    @Binding var availableExercises: [BodyExercise]
    @State private var currentTaskIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 15) {
            // Header
            HStack {
                Text("Daily Tasks")
                    .font(.headline)
                Spacer()
                Text("\(currentTaskIndex + 1)/\(max(tasks.count, 1))")
                Spacer()
            }
            .padding(.bottom, 10)
            
            // Task Content
            if !tasks.isEmpty {
                BodyTaskView(task: $tasks[currentTaskIndex], onTaskCompleted: handleTaskCompletion)
            } else {
                VStack {
                    Text("No tasks added")
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            }
            
            // Pagination Dots
            if tasks.count > 1 {
                HStack(spacing: 5) {
                    ForEach(0..<tasks.count, id: \.self) { index in
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
                    if value.translation.width < 0 && currentTaskIndex < tasks.count - 1 {
                        currentTaskIndex += 1
                    } else if value.translation.width > 0 && currentTaskIndex > 0 {
                        currentTaskIndex -= 1
                    }
                }
        )
    }
    
    private func handleTaskCompletion(taskId: UUID) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            if let index = tasks.firstIndex(where: { $0.id == taskId }) {
                let completedTask = tasks.remove(at: index)
                availableExercises.append(BodyExercise(name: completedTask.name))
                if currentTaskIndex >= tasks.count {
                    currentTaskIndex = max(tasks.count - 1, 0)
                }
            }
        }
    }
}


struct BodyTaskView: View {
    @Binding var task: BodyTask
    var onTaskCompleted: (UUID) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Text(task.name)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.bottom, 5)
            
            HStack {
                Button(action: {
                    task.count = max(0, task.count - 10)
                }) {
                    Image(systemName: "minus.circle")
                        .imageScale(.large)
                        .foregroundColor(Color(UIColor.systemRed))
                }
                
                Spacer()
                
                if task.completed {
                    Text("Well done!")
                        .font(.headline)
                        .foregroundColor(.green)
                        .transition(.opacity)
                } else {
                    Text(String(format: "%02d/%02d", task.count, task.dailyGoal))
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                Button(action: {
                    if !task.completed {
                        task.count = min(task.dailyGoal, task.count + 10)
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
                task.completed = true
            }
            onTaskCompleted(task.id)
        }
    }
}

struct BodyTask: Identifiable {
    let id = UUID()
    let name: String
    let dailyGoal: Int
    var count: Int = 0
    var completed: Bool = false
}
