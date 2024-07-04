//
//  Ship_4.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Ship_4: View {
    @Binding var shipType: Int
    @Binding var isPlayable: Bool
    @Binding var isPlaying: Bool
    @Binding var gameOver: Bool
    @Binding var shipPosition: CGPoint
    @Binding var bullets: [Bullet]
    @State var startShoot: Bool = false
    @State var shipPositionForBullet: CGPoint = CGPoint(
        x: UIScreen.main.bounds.width / 2,
        y: UIScreen.main.bounds.height / 2)
    @StateObject private var animationManager: AnimationManager = .init(
        images: [.ship41, .ship42, .ship43, .ship44, .ship45, .ship46, .ship47])
    
    var body: some View {
        ZStack {
            Ship_4_Bullets(bullets: $bullets, isPlaying: $startShoot, shipPositionForBullet: $shipPositionForBullet)
            
            Rectangle()
                .frame(width: 90, height: 90)
                .foregroundColor(Color.clear)
                .overlay {
                    Image(animationManager.images[animationManager.currentImageIndex])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .position(shipPosition)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if isPlayable {
                                self.shipPosition = value.location
                                self.isPlaying = true
                            }
                        }
                )
            
            if gameOver {
                Explode(size: 200)
                    .position(shipPosition)
            }
        }
        .onAppear(){
            shipType = 4
            animationManager.startAnimation()
        }
        .onChange(of: isPlaying) { _, newValue in
            startShoot = newValue
        }
        .onChange(of: shipPosition) { _, newValue in
            shipPositionForBullet = newValue
        }
        .onChange(of: gameOver) { _, newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    gameOver = false
                    isPlayable = true
                    withAnimation {
                        shipPosition = CGPoint(
                            x: UIScreen.main.bounds.width / 2,
                            y: (UIScreen.main.bounds.height / 2) - 50)
                    }
                }
            }
        }
    }
}

#Preview {
    Ship_4(shipType: .constant(4),
           isPlayable: .constant(true),
           isPlaying: .constant(true),
           gameOver: .constant(true),
           shipPosition: .constant(
            CGPoint(x: UIScreen.main.bounds.width / 2,
                    y: UIScreen.main.bounds.height / 2)),
           bullets: .constant([
            Bullet(position:CGPoint(x: UIScreen.main.bounds.width / 2,
                                    y: UIScreen.main.bounds.height / 2),
                   type: 1) ])
    )
}
