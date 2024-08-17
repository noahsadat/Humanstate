import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab: Int = 1
    @State private var headerTitle: String = "Humanstate"
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.modelContext) private var modelContext
    
    @Query private var bodyTasks: [BodyTask]
    @Query private var mindTasks: [MindTask]
    
    @State private var refreshID = UUID()
    @State private var availableBodyExercises: [BodyExercise] = BodyExercises.all
    @State private var availableMindExercises: [MindExercise] = MindExercises.all
    
    private let tabViewOffset: CGFloat = 20
    
    var body: some View {
            NavigationStack {
                ZStack(alignment: .top) {
                    DottedBackgroundView(
                        dotColor: Color.gray.opacity(0.3),
                        animatedDotColor: .blue.opacity(1),
                        backgroundColor: Color(uiColor: .systemGroupedBackground)
                    )
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    headerView
                        .padding(.horizontal)
                        .padding(.top)
                    
                    Spacer()
                }
                
                VStack {
                    Spacer().frame(height: 100)
                    
                    Group {
                        if selectedTab == 0 {
                            BodyView()
                                .onAppear { headerTitle = "Bodystate" }
                        } else if selectedTab == 1 {
                            homeContent
                                .onAppear { headerTitle = "Humanstate" }
                        } else if selectedTab == 2 {
                            MindView()
                                .onAppear { headerTitle = "Mindstate" }
                        }
                    }
                    
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    CustomTabView(selectedTab: $selectedTab)
                        .padding(.horizontal)
                        .padding(.bottom, -tabViewOffset)
                }
            }
            .navigationBarHidden(true)
        }
        .id(refreshID)
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .active {
                refreshTasks()
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Text(headerTitle)
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            NavigationLink(destination: ProfileView()) {
                Image(systemName: "person.circle.fill")
                    .font(.title)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
    
    private var homeContent: some View {
        VStack(spacing: 20) {
            CardView(
                title: "Body",
                progress: 56,
                readProgress: 0.5,
                exerciseProgress: calculateExerciseProgress(bodyTasks),
                nutritionProgress: 0.4
            )
            
            CardView(
                title: "Mind",
                progress: 50,
                readProgress: 0.4,
                exerciseProgress: calculateExerciseProgress(mindTasks),
                nutritionProgress: 0.6,
                isReversed: true
            )
            
            AllTasksView(
                                availableBodyExercises: $availableBodyExercises,
                                availableMindExercises: $availableMindExercises
                            )

            HStack(spacing: 20) {
                // Add any additional content here if needed
            }
        }
        .padding(.horizontal)
    }
    
    private func calculateExerciseProgress(_ tasks: [any TaskProtocol]) -> CGFloat {
        let completedTasks = tasks.filter { $0.completed }.count
        return tasks.isEmpty ? 0 : CGFloat(completedTasks) / CGFloat(tasks.count)
    }
    
    private func refreshTasks() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        for task in bodyTasks {
            if let lastCompletionDate = task.lastCompletionDate,
               !calendar.isDate(lastCompletionDate, inSameDayAs: today) {
                task.completed = false
                task.count = 0
                task.lastModifiedAt = Date()
            }
        }
        
        for task in mindTasks {
            if let lastCompletionDate = task.lastCompletionDate,
               !calendar.isDate(lastCompletionDate, inSameDayAs: today) {
                task.completed = false
                task.count = 0
                task.lastModifiedAt = Date()
            }
        }
        
        do {
            try modelContext.save()
            refreshID = UUID() // This will force a refresh of the entire view
        } catch {
            print("Failed to refresh tasks: \(error)")
        }
    }
}

protocol TaskProtocol {
    var completed: Bool { get }
    var lastCompletionDate: Date? { get }
}

extension BodyTask: TaskProtocol {}
extension MindTask: TaskProtocol {}

#Preview {
    ContentView()
        .modelContainer(for: [BodyTask.self, MindTask.self])
}


