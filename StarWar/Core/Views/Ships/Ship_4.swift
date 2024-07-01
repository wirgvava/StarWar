//
//  Ship_4.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Ship_4: View {
    @Binding var isPlaying: Bool
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
    Ship_4(isPlaying: .constant(true), 
           shipPosition: .constant(
            CGPoint(x: UIScreen.main.bounds.width / 2,
                    y: UIScreen.main.bounds.height / 2)),
           bullets: .constant([
            Bullet(position: CGPoint(x: UIScreen.main.bounds.width / 2,
                                     y: UIScreen.main.bounds.height / 2), 
                   type: 4 )])
    )
}
