import SwiftUI

struct BodyTasksView: View {
    @State private var tasks: [BodyTask] = []
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
                Button("Edit") {
                    // Edit action to be implemented
                }
                .font(.subheadline)
            }
            .padding(.bottom, 10)
            
            // Task Content
            if !tasks.isEmpty {
                BodyTaskView(task: tasks[currentTaskIndex])
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
}

struct BodyTask: Identifiable {
    let id = UUID()
    let name: String
    let viewName: String
}

struct BodyTaskView: View {
    let task: BodyTask
    @State private var count: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Text(task.name)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.bottom, 5)
            
            HStack {
                Button(action: {
                    count = max(0, count - 10)
                }) {
                    Image(systemName: "minus.circle")
                        .imageScale(.large)
                        .foregroundColor(Color(UIColor.systemRed))
                }
                
                Spacer()
                
                Text(String(format: "%02d", count))
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button(action: {
                    count += 10
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
}

struct BodyTasksView_Previews: PreviewProvider {
    static var previews: some View {
        BodyTasksView()
    }
}
