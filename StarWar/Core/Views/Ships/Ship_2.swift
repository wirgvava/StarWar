//
//  Ship_2.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Ship_2: View {
    @ObservedObject var appStorageManager = AppStorageManager.shared
    @Binding var shipType: Int
    @Binding var isPlayable: Bool
    @Binding var isPlaying: Bool
    @Binding var gameOver: Bool
    @Binding var shipPosition: CGPoint
    @Binding var bullets: [Bullet]
    @State private var rotateDegree: Double = 0
    @StateObject private var animationManager: AnimationManager = .init(
        images: [.ship21, .ship22, .ship23, .ship24, .ship25, .ship26])
    
    var isMovingLeft: Bool
    
    var body: some View {
        ZStack {
            Ship_2_Bullets(bullets: $bullets, 
                           shipPosition: $shipPosition,
                           isPlaying: $isPlaying)
            
            Rectangle()
                .frame(width: 70, height: 70)
                .foregroundColor(Color.clear)
                .overlay {
                    Image(animationManager.images[animationManager.currentImageIndex])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .rotationEffect(.degrees(rotateDegree))
                .position(shipPosition)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if appStorageManager.pointOfHealth != 0 {
                                if isPlayable {
                                    self.shipPosition.y = value.location.y - 100
                                    self.shipPosition.x = value.location.x
                                    self.isPlaying = true
                                }
                            } else {
                                vibration()
                            }
                        }
                )
            
            if gameOver {
                Explode(size: 165)
                    .position(shipPosition)
            }
        }
        .onAppear(){
            shipType = 2
            animationManager.startAnimation()
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
        .onChange(of: isMovingLeft) { _, newValue in
            if newValue {
                flyAwayAnimation(value: newValue, rotateDegree: -90, flyToCoordinateX: 0)
            } else {
                flyAwayAnimation(value: newValue, rotateDegree: 90, flyToCoordinateX: UIScreen.main.bounds.width / 2)
            }
        }
    }
    
    private func flyAwayAnimation(value: Bool, rotateDegree: Double, flyToCoordinateX: CGFloat){
        withAnimation(.linear(duration: 0.3)) {
            shipPosition = CGPoint(x: shipPosition.x,
                                   y: (UIScreen.main.bounds.height / 2) + 50)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.linear(duration: 1.0)) {
                shipPosition = CGPoint(x: UIScreen.main.bounds.width / 2,
                                       y: (UIScreen.main.bounds.height / 2))
                self.rotateDegree = rotateDegree

                shipPosition = CGPoint(x: flyToCoordinateX,
                                       y: (UIScreen.main.bounds.height / 2))
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.linear(duration: 1.5)) {
                self.rotateDegree = 0
                
                shipPosition = CGPoint(x: shipPosition.x,
                                       y: (UIScreen.main.bounds.height / 2) - 50)
            }
        }
    }
}

#Preview {
    Ship_2(shipType: .constant(1),
           isPlayable: .constant(true),
           isPlaying: .constant(true),
           gameOver: .constant(false),
           shipPosition: .constant(
            CGPoint(x: UIScreen.main.bounds.width / 2,
                    y: UIScreen.main.bounds.height / 2)),
           bullets: .constant([
            Bullet(position:CGPoint(x: UIScreen.main.bounds.width / 2,
                                    y: UIScreen.main.bounds.height / 2),
                   type: 1) ]),
           isMovingLeft: true
    )
}
