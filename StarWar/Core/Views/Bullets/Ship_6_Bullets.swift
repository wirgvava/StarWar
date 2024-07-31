//
//  Ship_6_Bullets.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 23.06.24.
//

import SwiftUI

struct Ship_6_Bullets: View {
    @Binding var bullets: [Bullet]
    @Binding var shipPosition: CGPoint
    @Binding var isPlaying: Bool
    @Binding var isPaused: Bool
      
    var body: some View {
        ForEach(bullets) { bullet in
            ZStack {
                Rectangle()
                    .foregroundColor(.pinkBullet)
                    .frame(width: 2, height: 4)
                    .position(x: bullet.position.x - 38,
                              y: bullet.position.y + 40)
                Rectangle()
                    .foregroundColor(.pinkBullet)
                    .frame(width: 2, height: 4)
                    .position(x: bullet.position.x - 30,
                              y: bullet.position.y + 40)
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: 4, height: 6)
                    .position(x: bullet.position.x - 18,
                              y: bullet.position.y + 20)
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: 6, height: 15)
                    .position(bullet.position)
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: 4, height: 6)
                    .position(x: bullet.position.x + 18,
                              y: bullet.position.y + 20)
                Rectangle()
                    .foregroundColor(.pinkBullet)
                    .frame(width: 2, height: 4)
                    .position(x: bullet.position.x + 30,
                              y: bullet.position.y + 40)
                Rectangle()
                    .foregroundColor(.pinkBullet)
                    .frame(width: 2, height: 4)
                    .position(x: bullet.position.x + 38,
                              y: bullet.position.y + 40)
            }
        }
        .ignoresSafeArea()
        .onChange(of: isPlaying) { _, newValue in
            if newValue {
                startBulletAnimation()
            } else {
                bullets.removeAll()
            }
        }
        .onChange(of: isPaused) { _, newValue in
            if newValue {
                withAnimation {
                    bullets.removeAll()
                }
            } else {
                startBulletAnimation()
            }
        }
    }
    
    // Start Shooting bullets
    private func startBulletAnimation() {
        guard isPlaying else { return }
        guard !isPaused else { return }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            moveBulletsTop()
            addBullet()
            startBulletAnimation()
        }
    }
    
    // Adding new bullets
    private func addBullet() {
        if bullets.count == 200 {
            bullets.removeFirst()
        }
        let newBullet = Bullet(
            position: CGPoint(
                x: shipPosition.x,
                y: shipPosition.y),
            type: 6)
        bullets.append(newBullet)
    }
    
    // Moving bullets to the top
    private func moveBulletsTop() {
        let screenHeight = UIScreen.main.bounds.height
        withAnimation {
            bullets = bullets.map { bullet in
                var newBullet = bullet
                newBullet.position.y -= 20
                return newBullet
            }.filter {
                $0.position.y <= screenHeight
            }
        }
    }
}
