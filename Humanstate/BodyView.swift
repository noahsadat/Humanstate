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

struct BodyActivityCard: View {
    let activity: String
    let completed: Int
    let total: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(activity)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text("Plan")
                    .foregroundColor(.blue)
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(total - completed) to go")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    ProgressView(value: Double(completed), total: Double(total))
                        .progressViewStyle(LinearProgressViewStyle())
                        .frame(width: 120)
                }
                Spacer()
                Text("\(completed)/\(total)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct BodyView_Previews: PreviewProvider {
    static var previews: some View {
        BodyView()
    }
}
