import SwiftUI

struct CustomTabView: View {
    @Binding var selectedTab: Int
    @State private var xOffset: CGFloat = 0
    @State private var viewWidth: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.primary.opacity(0.2))
                    .frame(width: geometry.size.width / 3, height: 48)
                    .offset(x: xOffset)
                
                HStack(spacing: 0) {
                    TabButton(title: "Body", tab: 0, selectedTab: $selectedTab, geometry: geometry)
                    TabButton(icon: "house.fill", tab: 1, selectedTab: $selectedTab, geometry: geometry)
                    TabButton(title: "Mind", tab: 2, selectedTab: $selectedTab, geometry: geometry)
                }
            }
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
            .shadow(color: Color.primary.opacity(0.1), radius: 10, x: 0, y: 5)
            .onChange(of: selectedTab) { oldValue, newValue in
                updateXOffset()
            }
            .onChange(of: geometry.size.width) { oldWidth, newWidth in
                viewWidth = newWidth
                updateXOffset()
            }
        }
        .frame(height: 60)
    }
    
    private func updateXOffset() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            xOffset = CGFloat(selectedTab) * (viewWidth / 3)
        }
    }
}

struct TabButton: View {
    var icon: String = ""
    var title: String = ""
    var tab: Int
    @Binding var selectedTab: Int
    let geometry: GeometryProxy
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTab = tab
            }
        }) {
            VStack {
                if !icon.isEmpty {
                    Image(systemName: icon)
                        .font(.title2)
                }
                if !title.isEmpty {
                    Text(title)
                        .font(.callout)
                        .fontWeight(.semibold)
                }
            }
            .foregroundStyle(selectedTab == tab ? .primary : .secondary)
            .frame(width: geometry.size.width / 3, height: 48)
        }
    }
}
