//
//  DottedBackground.swift
//  Humanstate
//
//  Created by Noah Sadat on 8/17/24.
//

import SwiftUI

struct DottedBackgroundView: View {
    let dotSize: CGFloat = 2
    let dotSpacing: CGFloat = 10
    let dotColor: Color
    let animatedDotColor: Color
    let backgroundColor: Color
    
    @State private var animatedDots: [(Int, Int, Bool)] = []
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        return backgroundColor
            .ignoresSafeArea()
            .overlay(
                Canvas { context, _ in
                    // Find the center point of the screen
                    let centerX = screenWidth / 2
                    let centerY = screenHeight / 2
                    
                    // Calculate how many dots we can fit on each side of the center
                    let dotsToRight = Int((screenWidth - centerX) / dotSpacing)
                    let dotsToLeft = Int(centerX / dotSpacing)
                    let dotsToBottom = Int((screenHeight - centerY) / dotSpacing)
                    let dotsToTop = Int(centerY / dotSpacing)
                    
                    // Draw dots from center outwards
                    for xOffset in -dotsToLeft...dotsToRight {
                        for yOffset in -dotsToTop...dotsToBottom {
                            let point = CGPoint(
                                x: centerX + CGFloat(xOffset) * dotSpacing,
                                y: centerY + CGFloat(yOffset) * dotSpacing
                            )
                            let rect = CGRect(
                                x: point.x - (dotSize / 2),
                                y: point.y - (dotSize / 2),
                                width: dotSize,
                                height: dotSize
                            )
                            
                            // Convert screen coordinates to grid coordinates for animation
                            let gridX = xOffset + dotsToLeft  // Normalize to 0-based index
                            let gridY = yOffset + dotsToTop   // Normalize to 0-based index
                            
                            if animatedDots.contains(where: { $0.0 == gridX && $0.1 == gridY && $0.2 }) {
                                context.fill(Path(ellipseIn: rect), with: .color(animatedDotColor))
                            } else {
                                context.fill(Path(ellipseIn: rect), with: .color(dotColor))
                            }
                        }
                    }
                }
                .frame(width: screenWidth, height: screenHeight)
                , alignment: .topLeading
            )
            .ignoresSafeArea()
            .onAppear {
                startAnimation()
            }
    }
    
    private func startAnimation() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.9)) {
                // Calculate grid dimensions based on screen size
                let dotsToRight = Int((UIScreen.main.bounds.width / 2) / dotSpacing)
                let dotsToLeft = Int((UIScreen.main.bounds.width / 2) / dotSpacing)
                let dotsToBottom = Int((UIScreen.main.bounds.height / 2) / dotSpacing)
                let dotsToTop = Int((UIScreen.main.bounds.height / 2) / dotSpacing)
                
                let totalColumns = dotsToLeft + dotsToRight + 1  // +1 for center column
                let totalRows = dotsToTop + dotsToBottom + 1     // +1 for center row
                
                // Remove some existing animated dots
                animatedDots = animatedDots.filter { _ in Bool.random() }
                
                // Add new animated dots
                let newDotsCount = Int.random(in: 1...20)
                for _ in 0..<newDotsCount {
                    let x = Int.random(in: 0..<totalColumns)
                    let y = Int.random(in: 0..<totalRows)
                    animatedDots.append((x, y, true))
                }
            }
        }
        timer.fire()
    }
}
