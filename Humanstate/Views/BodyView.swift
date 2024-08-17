import SwiftUI
import SwiftData

struct BodyView: View {
    @Query private var tasks: [BodyTask]
    @State private var availableExercises: [BodyExercise] = BodyExercises.all
    
    var body: some View {
        ZStack {
            // Animated dotted background
            DottedBackgroundView(
                dotColor: Color.gray.opacity(0.3),
                animatedDotColor: .blue.opacity(1),
                backgroundColor: Color(UIColor.systemGroupedBackground)
            )
            .edgesIgnoringSafeArea(.all)
            
            // Existing content
            VStack(spacing: 20) {
                BodyActivityCard(activity: "Read", completed: 8, total: 10, availableExercises: $availableExercises)
                BodyActivityCard(activity: "Exercise", completed: tasks.filter { $0.completed }.count, total: tasks.count, availableExercises: $availableExercises)
                BodyActivityCard(activity: "Nutrition", completed: 5, total: 10, availableExercises: $availableExercises)
                BodyTasksView(availableExercises: $availableExercises)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 20)
        }
    }
}

struct BodyView_Previews: PreviewProvider {
    static var previews: some View {
        BodyView()
    }
}
