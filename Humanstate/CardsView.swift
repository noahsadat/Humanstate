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
            // Background Circle
            Circle()
                .trim(from: 0.0, to: 1.0)
                .stroke(Color(UIColor.systemGray6).opacity(0.2), lineWidth: 20) // Use system color
                .frame(width: 120, height: 120)
            
            // Read Progress Segment
            Circle()
                .trim(from: 0.0, to: readProgress / 3)
                .stroke(Color(UIColor.systemBlue).opacity(readProgress > 0 ? 1 : 0.2), lineWidth: 20) // Use system color
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 120, height: 120)
            
            // Exercise Progress Segment
            Circle()
                .trim(from: 1 / 3, to: 1 / 3 + exerciseProgress / 3)
                .stroke(Color(UIColor.systemGreen).opacity(exerciseProgress > 0 ? 1 : 0.2), lineWidth: 20) // Use system color
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 120, height: 120)
            
            // Food Progress Segment
            Circle()
                .trim(from: 2 / 3, to: 2 / 3 + foodProgress / 3)
                .stroke(Color(UIColor.systemOrange).opacity(foodProgress > 0 ? 1 : 0.2), lineWidth: 20) // Use system color
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 120, height: 120)
            
            // Progress Text
            Text("\(progress)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary) // Use system primary color
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
            HStack {
                Circle()
                    .fill(Color(UIColor.systemBlue)) // Use system color
                    .frame(width: 10, height: 10)
                Text("Read")
                    .font(.headline)
                    .foregroundColor(.primary) // Use system primary color
            }
            HStack {
                Circle()
                    .fill(Color(UIColor.systemGreen)) // Use system color
                    .frame(width: 10, height: 10)
                Text("Exercise")
                    .font(.headline)
                    .foregroundColor(.primary) // Use system primary color
            }
            HStack {
                Circle()
                    .fill(Color(UIColor.systemOrange)) // Use system color
                    .frame(width: 10, height: 10)
                Text("Food")
                    .font(.headline)
                    .foregroundColor(.primary) // Use system primary color
            }
        }
        .padding()
    }
}

