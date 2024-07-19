//
//  Stars.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Stars: View {
    @State private var speedUpSwitcher: Bool = false
    @State private var stars: [Star] = []
    @State private var intervalBetweenStars = 0
    @State private var starMovementSpeed: CGFloat = 1
    @State private var bgOpacity = 1.0
    @Binding var isPlaying: Bool
       
    var body: some View {
        ZStack {
            // Background color
            Color.black.ignoresSafeArea()
            Color.space.ignoresSafeArea()
                .opacity(bgOpacity)
            
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
                speedUpSwitcher.toggle()
            } else {
                withAnimation {
                    starMovementSpeed = 1
                    bgOpacity = 1.0
                }
                startStarAnimation()
            }
        })
        .onChange(of: speedUpSwitcher) { _, _ in
            guard isPlaying else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                withAnimation {
                    bgOpacity -= 0.1
                    starMovementSpeed = min(5, starMovementSpeed + 0.5)
                }
                startStarAnimation()
                speedUpSwitcher.toggle()
            }
        }
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
        DispatchQueue.main.asyncAfter(deadline: .now()) {
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
            newStar.position.y += starMovementSpeed
            return newStar
        }.filter {
            $0.position.y <= screenHeight
        }
    }
}
