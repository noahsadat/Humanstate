import SwiftUI
import SwiftData

struct MindView: View {
    @Query private var tasks: [MindTask]
    @State private var availableExercises: [MindExercise] = MindExercises.all
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            MindActivityCard(activity: "Read", completed: 8, total: 10, availableExercises: $availableExercises)
            MindActivityCard(activity: "Exercise", completed: tasks.filter { $0.completed }.count, total: tasks.count, availableExercises: $availableExercises)
            MindActivityCard(activity: "Nutrition", completed: 5, total: 10, availableExercises: $availableExercises)
            MindTasksView(availableExercises: $availableExercises)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct MindView_Previews: PreviewProvider {
    static var previews: some View {
        MindView()
    }
}
