import SwiftUI
import SwiftData

struct MindView: View {
    @Query private var tasks: [MindTask]
    @State private var availableExercises: [MindExercise] = MindExercises.all
    
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
                MindActivityCard(activity: "Read", completed: 8, total: 10, availableExercises: $availableExercises)
                MindActivityCard(activity: "Exercise", completed: tasks.filter { $0.completed }.count, total: tasks.count, availableExercises: $availableExercises)
                MindActivityCard(activity: "Nutrition", completed: 5, total: 10, availableExercises: $availableExercises)
                MindTasksView(availableExercises: $availableExercises)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 20)
        }
    }
}

struct MindView_Previews: PreviewProvider {
    static var previews: some View {
        MindView()
    }
}
