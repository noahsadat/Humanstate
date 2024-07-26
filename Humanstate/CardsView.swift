import SwiftUI

struct CardView: View {
    var title: String
    var progress: Int
    var readProgress: CGFloat
    var exerciseProgress: CGFloat
    var foodProgress: CGFloat
    var isReversed: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            HStack {
                if isReversed {
                    ProgressCircle(progress: progress, readProgress: readProgress, exerciseProgress: exerciseProgress, foodProgress: foodProgress)
                    Spacer()
                    ProgressText(readProgress: readProgress, exerciseProgress: exerciseProgress, foodProgress: foodProgress)
                } else {
                    ProgressText(readProgress: readProgress, exerciseProgress: exerciseProgress, foodProgress: foodProgress)
                    Spacer()
                    ProgressCircle(progress: progress, readProgress: readProgress, exerciseProgress: exerciseProgress, foodProgress: foodProgress)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6)) // Match background color used in HomeView
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct ProgressCircle: View {
    var progress: Int
    var readProgress: CGFloat
    var exerciseProgress: CGFloat
    var foodProgress: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 1.0)
                .stroke(Color.secondary.opacity(0.2), lineWidth: 20)
                .frame(width: 120, height: 120)
            
            Circle()
                .trim(from: 0.0, to: readProgress / 3)
                .stroke(Color.blue, lineWidth: 20)
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 120, height: 120)
            
            Circle()
                .trim(from: 1 / 3, to: 1 / 3 + exerciseProgress / 3)
                .stroke(Color.green, lineWidth: 20)
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 120, height: 120)
            
            Circle()
                .trim(from: 2 / 3, to: 2 / 3 + foodProgress / 3)
                .stroke(Color.orange, lineWidth: 20)
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 120, height: 120)
            
            Text("\(progress)%")
                .font(.system(.title, design: .rounded).weight(.bold))
                .foregroundColor(.primary)
        }
        .padding()
    }
}

struct ProgressText: View {
    var readProgress: CGFloat
    var exerciseProgress: CGFloat
    var foodProgress: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ProgressRow(icon: "book.fill", text: "Read", color: .blue)
            ProgressRow(icon: "figure.walk", text: "Exercise", color: .green)
            ProgressRow(icon: "fork.knife", text: "Food", color: .orange)
        }
        .padding()
    }
}

struct ProgressRow: View {
    var icon: String
    var text: String
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
            Text(text)
                .font(.headline)
                .foregroundColor(.primary)
        }
    }
}
