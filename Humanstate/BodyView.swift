// BodyView.swift
import SwiftUI

struct BodyView: View {
    var body: some View {
        VStack(spacing: 20) {
            BodyActivityCard(activity: "Read", completed: 8, total: 10)
            BodyActivityCard(activity: "Exercise", completed: 3, total: 10)
            BodyActivityCard(activity: "Nutrition", completed: 5, total: 10)
            Spacer() // This will push the cards to the top
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
