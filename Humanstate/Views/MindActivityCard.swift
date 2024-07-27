// BodyActivityCard.swift
import SwiftUI

struct MindActivityCard: View {
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
