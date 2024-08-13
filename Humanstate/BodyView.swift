import SwiftUI
import SwiftData

struct BodyView: View {
    @Query private var tasks: [BodyTask]
    @State private var availableExercises: [BodyExercise] = BodyExercises.all
    
    var body: some View {
        VStack(spacing: 20) {
            BodyActivityCard(activity: "Read", completed: 8, total: 10, availableExercises: $availableExercises)
            BodyActivityCard(activity: "Exercise", completed: 3, total: 10, availableExercises: $availableExercises)
            BodyActivityCard(activity: "Nutrition", completed: 5, total: 10, availableExercises: $availableExercises)
            BodyTasksView(availableExercises: $availableExercises)
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
