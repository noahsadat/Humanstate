import SwiftUI

struct BodyView: View {
    @State private var tasks: [BodyTask] = []
    @State private var availableExercises: [BodyExercise] = BodyExercises.all
    
    var body: some View {
        VStack(spacing: 20) {
            BodyActivityCard(activity: "Read", completed: 8, total: 10, tasks: $tasks, availableExercises: $availableExercises)
            BodyActivityCard(activity: "Exercise", completed: 3, total: 10, tasks: $tasks, availableExercises: $availableExercises)
            BodyActivityCard(activity: "Nutrition", completed: 5, total: 10, tasks: $tasks, availableExercises: $availableExercises)
            BodyTasksView(tasks: $tasks, availableExercises: $availableExercises)
            Spacer()
        }
        .padding(.horizontal)
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

struct BodyView_Previews: PreviewProvider {
    static var previews: some View {
        BodyView()
    }
}
