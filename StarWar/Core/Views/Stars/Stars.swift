//
//  Stars.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI
import Combine

struct Stars: View {
    @State private var stars: [Star] = []
    @Binding var isPlaying: Bool
    @State private var intervalBetweenStars = 1
    @State private var index: Int = 0
    let speeds = [
        0.025, 0.01, 0.0075, 0.005, 0.0025, 0.001, 0
    ]
       
    var body: some View {
        ZStack {
            // Background color
            Color.space.edgesIgnoringSafeArea(.all)
            
            // Stars
            ForEach(stars) { star in
                starView(for: star.type)
                    .position(star.position)
            }
            .ignoresSafeArea()
        }
        .onAppear {
            spawnInitialStars()
            startStarAnimation()
        }
        .onChange(of: isPlaying, { _, newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    let lastIndex = speeds.count - 1
                    index = index == lastIndex ? lastIndex : index + 1
                    withAnimation(.smooth) {
                        startStarAnimation()
                    }
                }
            }
        })
        .onChange(of: index, { _, _ in
            guard index != speeds.count - 1 else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                index += 1
                withAnimation(.smooth) {
                    startStarAnimation()
                }
            }
        })
    }
   
    // Spawn initial stars on appear
    private func spawnInitialStars() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        for _ in 0..<200 {
            let x = CGFloat.random(in: 0...screenWidth)
            let y = CGFloat.random(in: 0...screenHeight)
            stars.append(Star(position: CGPoint(x: x, y: y),
                              type: Int.random(in: 1...32)))
        }
    }
    
    // Start normal speed star animation
    private func startStarAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + speeds[index]) {
            moveStarsDown()
            addStar()
            startStarAnimation()
        }
    }
    
    // Adding new stars on the top
    private func addStar() {
        guard stars.count != 200 else {
            stars.removeFirst()
            return
        }
        if intervalBetweenStars == 5 {
            let screenWidth = UIScreen.main.bounds.width
            let newStar = Star(
                position: CGPoint(
                    x: CGFloat.random(in: 0...screenWidth),
                    y: 0),
                type: Int.random(in: 1...32))
            stars.append(newStar)
            intervalBetweenStars = 1
        } else {
            intervalBetweenStars += 1
        }
    }
    
    // Moving stars to the bottom
    private func moveStarsDown() {
        let screenHeight = UIScreen.main.bounds.height
        stars = stars.map { star in
            var newStar = star
            newStar.position.y += 1
            return newStar
        }.filter {
            $0.position.y <= screenHeight
        }
    }
}

#Preview {
    Stars(isPlaying: .constant(true))
}
