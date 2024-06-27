//
//  Ship_6.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Ship_6: View {
    @State var startShoot: Bool = false
    @Binding var isPlaying: Bool
    @Binding var shipPosition: CGPoint

    @State var shipPositionForBullet: CGPoint = CGPoint(
        x: UIScreen.main.bounds.width / 2,
        y: UIScreen.main.bounds.height / 2
    )
    @StateObject private var animationManager: AnimationManager = .init(images: ["Ship 6.1", "Ship 6.2", "Ship 6.3", "Ship 6.4", "Ship 6.5", "Ship 6.6", "Ship 6.7", "Ship 6.8"])
    
    var body: some View {
        ZStack {
            Ship_6_Bullets(isPlaying: $startShoot, shipPositionForBullet: $shipPositionForBullet)
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
    Ship_6(isPlaying: .constant(true), shipPosition: .constant(
        CGPoint(
            x: UIScreen.main.bounds.width / 2,
            y: UIScreen.main.bounds.height / 2)
        )
    )
}
