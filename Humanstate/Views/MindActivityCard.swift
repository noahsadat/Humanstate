// MindActivityCard.swift
import SwiftUI

struct MindActivityCard: View {
    let activity: String
    let completed: Int
    let total: Int
    @State private var isPlanning: Bool = false
    @State private var selectedMindExercise: String = "Meditation"
    @State private var selectedDuration: Int = 5
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(activity)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(isPlanning ? "Cancel" : "Plan") {
                    withAnimation {
                        isPlanning.toggle()
                    }
                }
                .foregroundColor(.blue)
            }
            
            if !isPlanning {
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
            } else {
                if activity == "Exercise" {
                    mindExercisePlanningView
                } else {
                    Text("Planning for \(activity) is not implemented yet.")
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        .animation(.spring(), value: isPlanning)
    }
    
    private var mindExercisePlanningView: some View {
        VStack(spacing: 10) {
            GeometryReader { geometry in
                VStack(spacing: 5) {
                    HStack(spacing: 0) {
                        Text("Mind Exercise")
                            .frame(width: geometry.size.width * 0.65, alignment: .center)
                        Text("Duration (min)")
                            .frame(width: geometry.size.width * 0.35, alignment: .center)
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    
                    HStack(spacing: 0) {
                        Picker("Mind Exercise", selection: $selectedMindExercise) {
                            ForEach(["Meditation", "Breathing", "Visualization", "Journaling"], id: \.self) { exercise in
                                Text(exercise).tag(exercise)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: geometry.size.width * 0.65)
                        .clipped()
                        
                        Picker("Duration", selection: $selectedDuration) {
                            ForEach(1...12, id: \.self) { i in
                                Text("\(i * 5)").tag(i * 5)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: geometry.size.width * 0.35)
                        .clipped()
                    }
                }
            }
            .frame(height: 120)
            
            Button("Add") {
                // Here you would add the logic to save the mind exercise plan
                withAnimation {
                    isPlanning = false
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .frame(maxWidth: .infinity)
        }
    }
}
