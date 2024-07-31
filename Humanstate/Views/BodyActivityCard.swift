// BodyActivityCard.swift
import SwiftUI

struct BodyActivityCard: View {
    let activity: String
    let completed: Int
    let total: Int
    @State private var isPlanning: Bool = false
    @State private var selectedExercise: String = "Push Ups"
    @State private var selectedAmount: Int = 10
    
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
                    exercisePlanningView
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
    
    private var exercisePlanningView: some View {
        VStack(spacing: 10) {
            GeometryReader { geometry in
                VStack(spacing: 5) {
                    HStack(spacing: 0) {
                        Text("Exercise")
                            .frame(width: geometry.size.width * 0.65, alignment: .center)
                        Text("Daily Goal")
                            .frame(width: geometry.size.width * 0.35, alignment: .center)
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    
                    HStack(spacing: 0) {
                        Picker("Exercise", selection: $selectedExercise) {
                            ForEach(BodyExercises.all, id: \.name) { exercise in
                                Text(exercise.name).tag(exercise.name)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: geometry.size.width * 0.65)
                        .clipped()
                        
                        Picker("Amount", selection: $selectedAmount) {
                            ForEach(1...20, id: \.self) { i in
                                Text("\(i * 10)").tag(i * 5)
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
                // Here you would add the logic to save the exercise plan
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
