//
//  DottedBackground.swift
//  Humanstate
//
//  Created by Noah Sadat on 8/17/24.
//

import SwiftUI

struct DottedBackgroundView: View {
    let dotSize: CGFloat = 2
    let dotSpacing: CGFloat = 3
    let dotColor: Color
    let animatedDotColor: Color
    let backgroundColor: Color
    
    @State private var animatedDots: [(Int, Int, Bool)] = []
    
    var body: some View {
        GeometryReader { geometry in
            backgroundColor
                .overlay(
                    Canvas { context, size in
                        let columns = Int(size.width / dotSpacing)
                        let rows = Int(size.height / dotSpacing)
                        
                        for x in 0..<columns {
                            for y in 0..<rows {
                                let point = CGPoint(x: CGFloat(x) * dotSpacing, y: CGFloat(y) * dotSpacing)
                                let rect = CGRect(origin: point, size: CGSize(width: dotSize, height: dotSize))
                                
                                if animatedDots.contains(where: { $0.0 == x && $0.1 == y && $0.2 }) {
                                    context.fill(Path(ellipseIn: rect), with: .color(animatedDotColor))
                                } else {
                                    context.fill(Path(ellipseIn: rect), with: .color(dotColor))
                                }
                            }
                        }
                    }
                )
        }
        .onAppear {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.9)) {
                let columns = Int(UIScreen.main.bounds.width / dotSpacing)
                let rows = Int(UIScreen.main.bounds.height / dotSpacing)
                
                // Remove some existing animated dots
                animatedDots = animatedDots.filter { _ in Bool.random() }
                
                // Add new animated dots
                let newDotsCount = Int.random(in: 1...20)
                for _ in 0..<newDotsCount {
                    let x = Int.random(in: 0..<columns)
                    let y = Int.random(in: 0..<rows)
                    animatedDots.append((x, y, true))
                }
            }
        }
        timer.fire()
    }
}
