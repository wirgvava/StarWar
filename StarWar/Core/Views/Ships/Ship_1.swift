//
//  Ship_1.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Ship_1: View {
    @Binding var isPlaying: Bool
    @Binding var shipPosition: CGPoint
    @Binding var bullets: [Bullet]
    @State var startShoot: Bool = false
    @State var shipPositionForBullet: CGPoint = CGPoint(
        x: UIScreen.main.bounds.width / 2,
        y: UIScreen.main.bounds.height / 2)
    @StateObject private var animationManager: AnimationManager = .init(
        images: [.ship11, .ship12, .ship13])

    var body: some View {
        ZStack {
            Ship_1_Bullets(bullets: $bullets, isPlaying: $startShoot, shipPositionForBullet: $shipPositionForBullet)
            
            Rectangle()
                .frame(width: 50, height: 50)
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
                            self.shipPosition = value.location
                            self.isPlaying = true
                        }
                )
            
        }
        .onAppear(){
            animationManager.startAnimation()
        }
        .onChange(of: isPlaying) { _, newValue in
            startShoot = newValue
        }
        .onChange(of: shipPosition) { _, newValue in
            shipPositionForBullet = newValue
        }
    }
}

#Preview {
    Ship_1(isPlaying: .constant(true), 
           shipPosition: .constant(
            CGPoint(x: UIScreen.main.bounds.width / 2,
                    y: UIScreen.main.bounds.height / 2)),
           bullets: .constant([
            Bullet(position:CGPoint(x: UIScreen.main.bounds.width / 2,
                                    y: UIScreen.main.bounds.height / 2), 
                   type: 1) ])
    )
}
