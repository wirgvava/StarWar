//
//  Ship_6_Bullets.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 23.06.24.
//

import SwiftUI

struct Ship_6_Bullets: View {
    @Binding var bullets: [Bullet]
    @Binding var isPlaying: Bool
    @Binding var shipPositionForBullet: CGPoint
    @State private var timer: Timer?
  
    var body: some View {
        ForEach(bullets) { bullet in
            ZStack {
                Rectangle()
                    .foregroundColor(.pinkBullet)
                    .frame(width: 2, height: 4)
                    .position(x: bullet.position.x - 38,
                              y: bullet.position.y + 40)
                    .animation(.smooth, value: bullet.position)
                Rectangle()
                    .foregroundColor(.pinkBullet)
                    .frame(width: 2, height: 4)
                    .position(x: bullet.position.x - 30,
                              y: bullet.position.y + 40)
                    .animation(.smooth, value: bullet.position)
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: 4, height: 6)
                    .position(x: bullet.position.x - 18,
                              y: bullet.position.y + 20)
                    .animation(.smooth, value: bullet.position)
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: 6, height: 15)
                    .position(bullet.position)
                    .animation(.smooth, value: bullet.position)
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: 4, height: 6)
                    .position(x: bullet.position.x + 18,
                              y: bullet.position.y + 20)
                    .animation(.smooth, value: bullet.position)
                Rectangle()
                    .foregroundColor(.pinkBullet)
                    .frame(width: 2, height: 4)
                    .position(x: bullet.position.x + 30,
                              y: bullet.position.y + 40)
                    .animation(.smooth, value: bullet.position)
                Rectangle()
                    .foregroundColor(.pinkBullet)
                    .frame(width: 2, height: 4)
                    .position(x: bullet.position.x + 38,
                              y: bullet.position.y + 40)
                    .animation(.smooth, value: bullet.position)
            }
        }
        .ignoresSafeArea()
        .onChange(of: isPlaying) { _, newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    startBulletAnimation()
                }
            } else {
                stopBulletsAnimationTimer()
                bullets.removeAll()
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
                y: shipPositionForBullet.y), 
            type: 6)
        bullets.append(newBullet)
    }
    
    // Moving bullets to the top
    private func moveBulletsTop() {
        let screenHeight = UIScreen.main.bounds.height
        bullets = bullets.map { bullet in
            var newBullet = bullet
            newBullet.position.y -= 20
            return newBullet
        }.filter {
            $0.position.y <= screenHeight
        }
    }
}

#Preview {
    Ship_6_Bullets(bullets: .constant([Bullet(position:
                    CGPoint(x: UIScreen.main.bounds.width / 2,
                            y: UIScreen.main.bounds.height / 2), 
                                              type: 6)]),
                   isPlaying: .constant(true),
                   shipPositionForBullet: .constant(
                    CGPoint(
                        x: UIScreen.main.bounds.width / 2,
                        y: UIScreen.main.bounds.height / 2)))
}
