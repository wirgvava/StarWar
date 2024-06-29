//
//  Ship_2_Bullets.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 23.06.24.
//

import SwiftUI

struct Ship_2_Bullets: View {
    @Binding var bullets: [Bullet]
    @Binding var isPlaying: Bool
    @Binding var shipPositionForBullet: CGPoint
    @State private var timer: Timer?
  
    var body: some View {
        ForEach(bullets) { bullet in
            Rectangle()
                .foregroundColor(.pinkBullet)
                .frame(width: 6, height: 6)
                .position(bullet.position)
                .animation(.smooth, value: bullet.position)
        }
        .ignoresSafeArea()
        .onChange(of: isPlaying) { _, newValue in
            if newValue {
                startBulletAnimation()
            } else {
                stopBulletsAnimationTimer()
            }
        }.onDisappear(){
            stopBulletsAnimationTimer()
        }
    }
    
    // Start Shooting bullets
    private func startBulletAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: true, block: { _ in
            moveBulletsTop()
            addBullet()
        })
    }
    
    // Stop Timers
    private func stopBulletsAnimationTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // Adding new bullets
    private func addBullet() {
        if bullets.count == 200 {
            bullets.removeFirst()
        }
        let newBullet = Bullet(
            position: CGPoint(
                x: shipPositionForBullet.x,
                y: shipPositionForBullet.y + 10), 
            type: 2
            )
        bullets.append(newBullet)
    }
    
    // Moving bullets to the top
    private func moveBulletsTop() {
        let screenHeight = UIScreen.main.bounds.height
        bullets = bullets.map { bullet in
            var newBullet = bullet
            newBullet.position.y -= 15
            return newBullet
        }.filter {
            $0.position.y <= screenHeight
        }
    }
}

#Preview {
    Ship_2_Bullets(bullets: .constant([Bullet(position:
                    CGPoint(x: UIScreen.main.bounds.width / 2,
                            y: UIScreen.main.bounds.height / 2),
                                              type: 2)]),
                   isPlaying: .constant(true),
                   shipPositionForBullet: .constant(
                    CGPoint(
                        x: UIScreen.main.bounds.width / 2,
                        y: UIScreen.main.bounds.height / 2)))
}
