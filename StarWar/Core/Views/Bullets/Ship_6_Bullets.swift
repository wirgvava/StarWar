//
//  Ship_6_Bullets.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 23.06.24.
//

import SwiftUI

struct Ship_6_Bullets: View {
    @State private var bullets: [Bullet] = []
    @State private var timer: Timer?
    @Binding var isPlaying: Bool
    
    let screenHeight = UIScreen.main.bounds.height
    @Binding var shipPositionForBullet: CGPoint
  
    var body: some View {
        ZStack {
            ForEach(bullets) { bullet in
                ZStack {
                    Rectangle()
                        .foregroundColor(.pinkBullet)
                        .frame(width: 2, height: 4)
                        .position(x: bullet.position.x - 38,
                                  y: bullet.position.y + 40)
                        .animation(.linear(duration: 0.1), value: bullet.position)
                    Rectangle()
                        .foregroundColor(.pinkBullet)
                        .frame(width: 2, height: 4)
                        .position(x: bullet.position.x - 30,
                                  y: bullet.position.y + 40)
                        .animation(.linear(duration: 0.1), value: bullet.position)
                    Rectangle()
                        .foregroundColor(.orange)
                        .frame(width: 4, height: 6)
                        .position(x: bullet.position.x - 18,
                                  y: bullet.position.y + 20)
                        .animation(.linear(duration: 0.1), value: bullet.position)
                    Rectangle()
                        .foregroundColor(.yellow)
                        .frame(width: 6, height: 15)
                        .position(bullet.position)
                        .animation(.linear(duration: 0.1), value: bullet.position)
                    Rectangle()
                        .foregroundColor(.orange)
                        .frame(width: 4, height: 6)
                        .position(x: bullet.position.x + 18,
                                  y: bullet.position.y + 20)
                        .animation(.linear(duration: 0.1), value: bullet.position)
                    Rectangle()
                        .foregroundColor(.pinkBullet)
                        .frame(width: 2, height: 4)
                        .position(x: bullet.position.x + 38,
                                  y: bullet.position.y + 40)
                        .animation(.linear(duration: 0.1), value: bullet.position)
                    Rectangle()
                        .foregroundColor(.pinkBullet)
                        .frame(width: 2, height: 4)
                        .position(x: bullet.position.x + 30,
                                  y: bullet.position.y + 40)
                        .animation(.linear(duration: 0.1), value: bullet.position)
                }
            }
            .ignoresSafeArea()
        }
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
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
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
        let newBullet = Bullet(
            position: CGPoint(
                x: shipPositionForBullet.x,
                y: shipPositionForBullet.y)
            )
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
    Ship_6_Bullets(isPlaying: .constant(true), shipPositionForBullet: .constant(
        CGPoint(
            x: UIScreen.main.bounds.width / 2,
            y: UIScreen.main.bounds.height / 2)
        )
    )
}
