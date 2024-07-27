// MindView.swift
import SwiftUI

struct MindView: View {
    var body: some View {
        VStack(spacing: 20) {
            MindActivityCard(activity: "Read", completed: 8, total: 10)
            MindActivityCard(activity: "Exercise", completed: 3, total: 10)
            MindActivityCard(activity: "Nutrition", completed: 5, total: 10)
            Spacer() // This will push the cards to the top
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
