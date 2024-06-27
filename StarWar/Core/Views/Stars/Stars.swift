//
//  Stars.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Star: Identifiable {
    let id = UUID()
    var position: CGPoint
}

struct Stars: View {
    @State private var stars: [Star] = []
    @State private var timer: Timer?
    @State private var speedUpTimer: Timer?
    @Binding var isPlaying: Bool
    @State private var index: Int = 0
    let starAnimationSpeeds = [0.1, 0.075, 0.05, 0.025, 0.01, 0.0075, 0,005, 0.0025, 0.001]
    
    var body: some View {
        ZStack {
            // Background color
            Color.space.edgesIgnoringSafeArea(.all)
            
            // Stars
            ForEach(stars) { star in
                Circle()
                    .fill(Color.white)
                    .opacity(CGFloat.random(in: 0...0.8))
                    .frame(width: CGFloat.random(in: 1...10),
                           height: CGFloat.random(in: 1...10))
                    .position(star.position)
                    .animation(.linear(duration: 0.1), value: star.position)
            }
            .ignoresSafeArea()
        }
        .onAppear {
            spawnInitialStars()
            startStarAnimation()
        }
        .onChange(of: isPlaying, { _, newValue in
            if newValue {
                speedUpStars()
            } else {
                startStarAnimation()
            }
        })
        .onDisappear {
            stopStarAnimationTimer()
            stopSpeedUpTimer()
        }
    }
    
    // Spawn initial stars on appear
    private func spawnInitialStars() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        for _ in 0..<100 {
            let x = CGFloat.random(in: 0...screenWidth)
            let y = CGFloat.random(in: 0...screenHeight)
            stars.append(Star(position: CGPoint(x: x, y: y)))
        }
    }
    
    // Speed Up Star animations
    private func speedUpStars(){
        let lastIndex = starAnimationSpeeds.count - 1
        speedUpTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
            index = index == lastIndex ? lastIndex : index + 1
            startStarAnimation()
        }
    }
    
    // Start normal speed star animation
    private func startStarAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: starAnimationSpeeds[index], repeats: true, block: { _ in
            moveStarsDown()
            addStar()
        })
    }
    
    // Stop Timers
    private func stopStarAnimationTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func stopSpeedUpTimer(){
        speedUpTimer?.invalidate()
        speedUpTimer = nil
    }
    
    // Adding new stars on the top
    private func addStar() {
        let screenWidth = UIScreen.main.bounds.width
        let newStar = Star(position: CGPoint(x: CGFloat.random(in: 0...screenWidth), y: 0))
        stars.append(newStar)
    }
    
    // Moving stars to the bottom
    private func moveStarsDown() {
        let screenHeight = UIScreen.main.bounds.height
        stars = stars.map { star in
            var newStar = star
            newStar.position.y += 5
            return newStar
        }.filter {
            $0.position.y <= screenHeight
        }
    }
}

#Preview {
    Stars(isPlaying: .constant(true))
}
