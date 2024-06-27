//
//  Ship_1.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Ship_1: View {
    @StateObject private var animationManager: AnimationManager = .init(images: ["Ship 1.1", "Ship 1.2", "Ship 1.3"])
    
    @State var startShoot: Bool = false
    @Binding var isPlaying: Bool
    
    @State var shipPositionForBullet: CGPoint = CGPoint(x: 0, y: 0)
    @Binding var shipPosition: CGPoint

    var body: some View {
        ZStack {
            Ship_1_Bullets(isPlaying: $startShoot, shipPositionForBullet: $shipPositionForBullet)
            
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
    Ship_1(isPlaying: .constant(true), shipPosition: .constant(
        CGPoint(
            x: UIScreen.main.bounds.width / 2,
            y: UIScreen.main.bounds.height / 2)
        )
    )
}
