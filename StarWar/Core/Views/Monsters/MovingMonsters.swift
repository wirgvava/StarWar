//
//  MovingMonsters.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 27.06.24.
//

import SwiftUI

struct MovingMonsters: View {
    @Binding var bullets: [Bullet]
    @Binding var isPlayable: Bool
    @Binding var isPlaying: Bool
    @Binding var gameOver: Bool
    @Binding var shipPosition: CGPoint
    @Binding var score: Int
    @State private var monsters: [Monster] = []
    @State private var explosions: [Explosion] = []
    @State private var intervalBetweenMonsters = 1
    @State private var index: Int = 0
    var shipType: Int
    let speeds: [TimeInterval] = [
        0.05, 0.045, 0.04, 0.035, 0.03, 0.025, 0.02, 0.015, 0.01,
        0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.001, 0
    ]
        
    var body: some View {
        ZStack {
            ForEach(monsters) { monster in
                monsterView(for: monster.monsterType)
                    .position(monster.position)
            }
            .ignoresSafeArea()
            
            ForEach(explosions) { explosion in
                Explode(size: 90)
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    let lastIndex = speeds.count - 1
                    index = index == lastIndex ? lastIndex : index + 1
                    startMonsterAnimation()
                }
            } else {
                index = 0
            }
        })
        .onChange(of: index, { _, _ in
            guard index != speeds.count - 1 else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                index = isPlaying ? index + 1 : index
                withAnimation(.smooth) {
                    startMonsterAnimation()
                }
            }
        })
    }
    
    // Speed Up Monster animations
    private func startMonsterAnimation(){
        if isPlaying {
            DispatchQueue.main.asyncAfter(deadline: .now() + speeds[index]){
                moveMonstersDown()
                addMonsters()
                detectCollisions()
                startMonsterAnimation()
            }
        }
    }

    // Adding new monsters on the top
    private func addMonsters(){
        if intervalBetweenMonsters == 30 {
            let screenWidth = UIScreen.main.bounds.width
            let newMonster = Monster(
                position: CGPoint(
                    x: CGFloat.random(in: 0...screenWidth),
                    y: 0),
                monsterType: Int.random(in: 1...4))
            monsters.append(newMonster)
            intervalBetweenMonsters = 1
        } else {
            intervalBetweenMonsters += 1
        }
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
    
    // Detect collisions
    private func detectCollisions() {
        detectCollisionsForMonsters()
        detectCollisionsForTheShip()
    }
    
    // Check for collision between Bullets and Monsters
    private func detectCollisionsForMonsters(){
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
    
    // Check for collision between monsters and the ship
    private func detectCollisionsForTheShip(){
        for monster in monsters {
            if monsterHitsShip(monster: monster, shipPosition: shipPosition) {
                withAnimation(.easeOut) {
                    gameOver = true
                    isPlayable = false
                    isPlaying = false
                    triggerExplosion(at: shipPosition)
                    removeMonsters()
                }
                break
            }
        }
    }
    
    // Monster distance to the ship
    private func monsterHitsShip(monster: Monster, shipPosition: CGPoint) -> Bool {
        let monsterPosition = CGRect(x: monster.position.x, y: monster.position.y - 60, width: 50, height: 50)
        
        var shipSize: CGFloat = 50
        
        switch shipType {
        case 1: shipSize = 50
        case 2: shipSize = 70
        case 3: shipSize = 80
        case 4: shipSize = 90
        case 5: shipSize = 90
        case 6: shipSize = 90
        default:shipSize = 50
        }
        
        let shipPosition = CGRect(x: shipPosition.x, y: shipPosition.y, width: shipSize, height: shipSize)
        
        return shipPosition.intersects(monsterPosition)
    }
    
    // Bullets distance to monster
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
    
    // Explosion
    private func triggerExplosion(at position: CGPoint) {
        let newExplosion = Explosion(position: position, 
                                     animationDuration: 0.2)
        explosions.append(newExplosion)
    }
}
