//
//  MovingMeteors.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 11.07.24.
//

import SwiftUI

struct MovingMeteors: View {
    @ObservedObject var appStorageManager = AppStorageManager.shared
    @State private var meteors = [Meteor]()
    @State private var explosions = [Explosion]()
    @State private var intervalBetweenMeteors = 0
    @Binding var isPlayable: Bool
    @Binding var isPlaying: Bool
    @Binding var gameOver: Bool
    @Binding var shipPosition: CGPoint

    var body: some View {
        ZStack {
            ForEach(meteors) { meteor in
                MeteorView(size: 100)
                    .position(meteor.position)
            }
            .ignoresSafeArea()
        }
        .onChange(of: isPlaying) { _, newValue in
            if newValue {
                startMeteorAnimation()
            } else {
                intervalBetweenMeteors = 0
                removeMeteors()
            }
        }
    }
    
    // Start falling meteor animation
    private func startMeteorAnimation(){
        guard isPlaying else { return }
        DispatchQueue.main.asyncAfter(deadline: .now()){
            moveMeteorsDown()
            addMeteors()
            detectCollisionsForTheShip()
            startMeteorAnimation()
        }
    }

    // Adding new meteors on the top
    private func addMeteors(){
        if intervalBetweenMeteors == 1500 {
            let screenWidth = UIScreen.main.bounds.width
            let newMeteor = Meteor(
                position: CGPoint(
                    x: CGFloat.random(in: 0...screenWidth),
                    y: 0))
            meteors.append(newMeteor)
            intervalBetweenMeteors = 0
        } else {
            intervalBetweenMeteors += 1
        }
    }
    
    // Moving meteors to the bottom
    private func moveMeteorsDown(){
        let screenHeight = UIScreen.main.bounds.height
        meteors = meteors.map { meteor in
            var newMeteor = meteor
            newMeteor.position.y += 5
            return newMeteor
        }.filter {
            $0.position.y <= screenHeight
        }
    }
    
    private func removeMeteors(){
        meteors.removeAll()
    }
   
    // Check for collision between meteors and the ship
    private func detectCollisionsForTheShip(){
        for meteor in meteors {
            if meteorHitsShip(meteor: meteor, shipPosition: shipPosition) {
                withAnimation(.easeOut) {
                    gameOver = true
                    isPlayable = false
                    isPlaying = false
                    triggerExplosion(at: shipPosition)
                    removeMeteors()
                }
                break
            }
        }
    }
    
    // Meteor distance to the ship
    private func meteorHitsShip(meteor: Meteor, shipPosition: CGPoint) -> Bool {
        let meteorPosition = CGRect(x: meteor.position.x, y: meteor.position.y - 60, width: 50, height: 100)
        let shipSize = sizeForShip(type: appStorageManager.shipType)
        let shipPosition = CGRect(x: shipPosition.x, y: shipPosition.y, width: shipSize, height: shipSize)
        
        return shipPosition.intersects(meteorPosition)
    }
    
    // Explosion
    private func triggerExplosion(at position: CGPoint) {
        let newExplosion = Explosion(position: position,
                                     animationDuration: 0.2)
        explosions.append(newExplosion)
    }
}
