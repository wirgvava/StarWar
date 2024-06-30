//
//  MovingMonsters.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 27.06.24.
//

import SwiftUI

struct MovingMonsters: View {
    @Binding var bullets: [Bullet]
    @State private var monsters: [Monster] = []
    @State private var explosions: [Explosion] = []
    @State private var movingDownTimer: Timer?
    @State private var addingMonstersTimer: Timer?
    @State private var speedUpTimer: Timer?
    @Binding var isPlaying: Bool
    @Binding var score: Int
    @State private var index: Int = 0
    let monsterAnimationSpeeds = [0.1, 0.075, 0.05, 0.025, 0.01]
    
    var body: some View {
        ZStack {
            ForEach(monsters) { monster in
                monsterView(for: monster.monsterType)
                    .position(monster.position)
            }
            .ignoresSafeArea()
            
            ForEach(explosions) { explosion in
                Explode()
                    .position(x: explosion.position.x,
                              y: explosion.position.y - 50)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + explosion.animationDuration) {
                            if let index = explosions.firstIndex(where: { $0.id == explosion.id }) {
                                explosions.remove(at: index)
                            }
                        }
                    }
            }
        }
        .onChange(of: isPlaying, { _, newValue in
            if newValue {
                startMonsterAnimation()
            } else {
                removeMonsters()
            }
        })
        .onDisappear {
            stopMonsterAnimationTimers()
        }
    }
    
    // Function to return the appropriate monster view based on the monster type
    @ViewBuilder
    private func monsterView(for type: Int) -> some View {
        switch type {
        case 1:
            Monster_1()
        case 2:
            Monster_2()
        case 3:
            Monster_3()
        case 4:
            Monster_4()
        default:
            Monster_1()
        }
    }
    
    // Speed Up Monster animations
    private func startMonsterAnimation(){
        let lastIndex = monsterAnimationSpeeds.count - 1
        speedUpTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
            index = index == lastIndex ? lastIndex : index + 1
            addMoveAnimation()
        }
    }
    
    // Start normal speed monster animation
    private func addMoveAnimation(){
        movingDownTimer = Timer.scheduledTimer(withTimeInterval: monsterAnimationSpeeds[index], repeats: true) { _ in
            moveMonstersDown()
            detectCollisions()
        }
        
        addingMonstersTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            addMonsters()
        }
    }
    
    // Stop Timers
    private func stopMonsterAnimationTimers(){
        movingDownTimer?.invalidate()
        addingMonstersTimer?.invalidate()
        speedUpTimer?.invalidate()
        movingDownTimer = nil
        addingMonstersTimer = nil
        speedUpTimer = nil
    }
    
    // Adding new monsters on the top
    private func addMonsters(){
        let screenWidth = UIScreen.main.bounds.width
        let newMonster = Monster(
            position: CGPoint(
                x: CGFloat.random(in: 0...screenWidth),
                y: 0), 
            monsterType: Int.random(in: 1...4))
        monsters.append(newMonster)
    }
    
    // Moving monsters to the bottom
    private func moveMonstersDown(){
        let screenHeight = UIScreen.main.bounds.height
        monsters = monsters.map { monster in
            var newMonster = monster
            newMonster.position.y += 1
            return newMonster
        }.filter {
            $0.position.y <= screenHeight
        }
    }
    
    private func removeMonsters(){
        monsters.removeAll()
    }
    
    // Detect collisions between bullets and monsters
    private func detectCollisions() {
        for bullet in bullets {
            for monster in monsters {
                if kill(monster: monster, with: bullet) {
                    if let monsterIndex = monsters.firstIndex(where: { $0.id == monster.id }) {
                        monsters.remove(at: monsterIndex)
                        triggerExplosion(at: monster.position)
                        score += 2
                    }
                    break
                }
            }
        }
    }
    
    private func kill(monster: Monster, with bullet: Bullet) -> Bool {
        switch bullet.type {
        case 1, 2, 3:
            return bullet.position.distance(to: monster.position) < 20
            
        case 4:
            let offsets: [(CGFloat, CGFloat)] = [
                (-25, 20), (0, 0), (25, 20)
            ]
            return bulletPositionDistance(with: offsets, bullet: bullet, monster: monster)
            
        case 5:
            let offsets: [(CGFloat, CGFloat)] = [
                (-28, 25),(-14, 25), (0, 0), (14, 25), (28, 25)
            ]
            return bulletPositionDistance(with: offsets, bullet: bullet, monster: monster)
            
        case 6:
            let offsets: [(CGFloat, CGFloat)] = [
                (-38, 40), (-30, 40), (-18, 20), (0, 0), (18, 20), (30, 40), (38, 40)
            ]
            return bulletPositionDistance(with: offsets, bullet: bullet, monster: monster)
            
            
        default:
            return bullet.position.distance(to: monster.position) < 20
        }
    }
    
    private func bulletPositionDistance(with offsets: [(CGFloat, CGFloat)], bullet: Bullet, monster: Monster) -> Bool {
        return offsets.contains { offset in
            let bulletPosition = CGPoint(
                x: bullet.position.x + offset.0,
                y: bullet.position.y + offset.1)
            return bulletPosition.distance(to: monster.position) < 20
        }
    }
    
    private func triggerExplosion(at position: CGPoint) {
        let newExplosion = Explosion(position: position, 
                                     animationDuration: 0.2)
        explosions.append(newExplosion)
    }
}

#Preview {
    MovingMonsters(bullets: .constant([Bullet(position: CGPoint(x: 100, y: 100), type: 1)]), isPlaying: .constant(true), score: .constant(0))
}
