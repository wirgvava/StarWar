//
//  ContentView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct ContentView: View {
    @State private var shipPosition: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
    @State private var bulletPosition: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 280)
    @State private var bulletIsAnimating: Bool = false
    
    @State private var starWarBannerTop: CGFloat = -300
    
    var body: some View {
        ZStack {
            Color("Space", bundle: nil).ignoresSafeArea()
            
            Image("StarWar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, starWarBannerTop)
                .padding(.horizontal)
            
            if bulletIsAnimating {
                Image("Bullets 1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 8, height: 50)
                    .position(bulletPosition)
                    .onAppear {
                        startBulletAnimation()
                    }
            }
            
            Ship_1()
                .frame(width: 80, height: 80)
                .position(shipPosition)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation {
                                self.starWarBannerTop = -1000
                            }
                            self.bulletIsAnimating = true
                            self.shipPosition = value.location
                            self.bulletPosition = CGPoint(x: value.location.x, y: self.bulletPosition.y)
                        }
                )
        }
    }
    
    private func startBulletAnimation() {
        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
            //                bulletIsAnimating = true
        }
        Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { _ in
            if bulletIsAnimating {
                bulletPosition.y -= 5
                if bulletPosition.y < 0 {
                    bulletPosition = CGPoint(x: shipPosition.x, y: shipPosition.y - 50)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
