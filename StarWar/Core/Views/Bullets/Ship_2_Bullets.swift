//
//  Ship_2_Bullets.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 23.06.24.
//

import SwiftUI

struct Ship_2_Bullets: View {
    @Binding var bullets: [Bullet]
    @Binding var shipPosition: CGPoint
    @Binding var isPlaying: Bool
  
    var body: some View {
        ForEach(bullets) { bullet in
            Rectangle()
                .foregroundColor(.pinkBullet)
                .frame(width: 6, height: 6)
                .position(bullet.position)
        }
        .ignoresSafeArea()
        .onChange(of: isPlaying) { _, newValue in
            if newValue {
                startBulletAnimation()
            } else {
                bullets.removeAll()
            }
        }
    }
    
    // Start Shooting bullets
    private func startBulletAnimation() {
        guard isPlaying else { return }
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
                y: shipPosition.y + 10),
            type: 2
            )
        bullets.append(newBullet)
    }
    
    // Moving bullets to the top
    private func moveBulletsTop() {
        let screenHeight = UIScreen.main.bounds.height
        withAnimation {
            bullets = bullets.map { bullet in
                var newBullet = bullet
                newBullet.position.y -= 15
                return newBullet
            }.filter {
                $0.position.y <= screenHeight
            }
        }
    }
}
