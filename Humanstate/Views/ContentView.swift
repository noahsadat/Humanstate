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
    
    @State private var contentOffset: CGFloat = 0
    
    private let tabViewOffset: CGFloat = 20
    private let headerToContentPadding: CGFloat = 20
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                DottedBackgroundView(
                    dotColor: Color.white.opacity(0.3),
                    animatedDotColor: .gray.opacity(1),
                    backgroundColor: Color(uiColor: .systemGroupedBackground)
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    headerView
                        .padding(.horizontal)
                        .padding(.top)
                    
                    GeometryReader { geometry in
                        HStack(spacing: 0) {
                            BodyView()
                                .frame(width: geometry.size.width)
                            homeContent
                                .frame(width: geometry.size.width)
                            MindView()
                                .frame(width: geometry.size.width)
                        }
                        .offset(x: -CGFloat(selectedTab) * geometry.size.width + contentOffset)
                        .animation(.interactiveSpring(), value: selectedTab)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    contentOffset = gesture.translation.width
                                }
                                .onEnded { gesture in
                                    let predictedEndOffset = gesture.predictedEndTranslation.width
                                    let threshold = geometry.size.width * 0.3
                                    
                                    if abs(predictedEndOffset) > threshold {
                                        if predictedEndOffset > 0 {
                                            selectedTab = max(0, selectedTab - 1)
                                        } else {
                                            selectedTab = min(2, selectedTab + 1)
                                        }
                                    }
                                    
                                    contentOffset = 0
                                }
                        )
                    }
                    .padding(.top, headerToContentPadding)
                    
                    Spacer()
                    
                    CustomTabView(selectedTab: $selectedTab)
                        .padding(.horizontal)
                        .padding(.bottom, -tabViewOffset)
                }
            }
            .navigationBarHidden(true)
        }
        .id(refreshID)
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                refreshTasks()
            }
        }
        .onChange(of: selectedTab) { _, _ in
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
            VStack(alignment: .leading, spacing: 20) {
                CardView(
                    title: "Body",
                    progress: 56,
                    readProgress: 1,
                    exerciseProgress: calculateExerciseProgress(bodyTasks),
                    nutritionProgress: 1
                )
                
                CardView(
                    title: "Mind",
                    progress: 50,
                    readProgress: 1,
                    exerciseProgress: calculateExerciseProgress(mindTasks),
                    nutritionProgress: 1,
                    isReversed: true
                )
                
                AllTasksView(
                    availableBodyExercises: $availableBodyExercises,
                    availableMindExercises: $availableMindExercises
                )
                
                Spacer()
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


