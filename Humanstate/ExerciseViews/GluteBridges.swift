import SwiftUI

struct GluteBridgesView: View {
    @State private var count: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Glute Bridges")
                .font(.headline)
                .foregroundColor(.primary) // Match the primary color used in HomeView
                .padding(.bottom, 5)
            
            HStack {
                Button(action: {
                    count = max(0, count - 10)
                }) {
                    Image(systemName: "minus.circle")
                        .imageScale(.large)
                        .foregroundColor(Color(UIColor.systemRed)) // Change to match theme
                }
                
                Spacer()
                
                Text(String(format: "%02d", count))
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .foregroundColor(.primary) // Match the primary color used in HomeView
                
                Spacer()
                
                Button(action: {
                    count += 10
                }) {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                        .foregroundColor(Color(UIColor.systemGreen)) // Change to match theme
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6)) // Match background color used in HomeView
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct GluteBridgesView_Previews: PreviewProvider {
    static var previews: some View {
        GluteBridgesView()
            .frame(width: 200, height: 100) // Adjust size as needed
    }
}
