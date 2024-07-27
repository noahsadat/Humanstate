// ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 1
    @State private var headerTitle: String = "Humanstate"
    @Environment(\.colorScheme) private var colorScheme
    
    private let tabViewOffset: CGFloat = 20
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    headerView
                        .padding(.horizontal)
                        .padding(.top)
                    
                    Spacer()
                }
                
                VStack {
                    Spacer().frame(height: 100) // Adjust this value to position the content correctly
                    
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
    }
    
    private var headerView: some View {
        HStack {
            Text(headerTitle)
                .font(.largeTitle)
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
            CardView(title: "Body", progress: 56, readProgress: 0.5, exerciseProgress: 0.8, nutritionProgress: 0.4)
            
            CardView(title: "Mind", progress: 50, readProgress: 0.4, exerciseProgress: 0.5, nutritionProgress: 0.6, isReversed: true)

            HStack(spacing: 20) {
                PushUpsView()
                BurpeesView()
            }
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
