import SwiftUI

struct MindView: View {
    @State private var tasks: [MindTask] = []
    @State private var availableExercises: [MindExercise] = MindExercises.all
    
    var body: some View {
        VStack(spacing: 20) {
            MindActivityCard(activity: "Read", completed: 8, total: 10, tasks: $tasks, availableExercises: $availableExercises)
            MindActivityCard(activity: "Exercise", completed: 3, total: 10, tasks: $tasks, availableExercises: $availableExercises)
            MindActivityCard(activity: "Nutrition", completed: 5, total: 10, tasks: $tasks, availableExercises: $availableExercises)
            MindTasksView(tasks: $tasks, availableExercises: $availableExercises)
            Spacer()
        }
        .padding(.horizontal)
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

struct MindView_Previews: PreviewProvider {
    static var previews: some View {
        MindView()
    }
}
