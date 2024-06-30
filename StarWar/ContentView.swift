//
//  ContentView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct ContentView: View {
    @State private var shipPosition: CGPoint = CGPoint(
        x: UIScreen.main.bounds.width / 2,
        y: (UIScreen.main.bounds.height / 2) - 50)
    @State private var starWarBannerTop: CGFloat = -300
    @State private var isPlaying: Bool = false
    @State private var bullets: [Bullet] = []
    
    @State private var score: Int = 0
    @State private var scoreTopPadding: CGFloat = -600
    
    var body: some View {
        ZStack {      
            Stars(isPlaying: $isPlaying)
                .scaleEffect(isPlaying ? 1.0 : 2.0)
                .animation(.easeOut, value: isPlaying)
         
            MovingMonsters(bullets: $bullets, isPlaying: $isPlaying, score: $score)
            
            VStack {
                Image("StarWar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, starWarBannerTop)
                    .padding(.horizontal)
            }
            
            HStack {
                HStack {
                    Image("Health(full)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    Image("Health(half)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    Image("Health(empty)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
                
                Spacer()
                
                Text("Score\n\(score)")
                    .font(.custom("Minecraft", fixedSize: 24))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.trailing)
            }
            .padding(.horizontal)
            .padding(.top, scoreTopPadding)
            
            Ship_1(isPlaying: $isPlaying, shipPosition: $shipPosition, bullets: $bullets)
                .scaleEffect(isPlaying ? 1.0 : 1.8)
                .animation(.easeOut, value: isPlaying)
        }
        .onChange(of: isPlaying) { _, newValue in
            if newValue {
                withAnimation(.snappy) {
                    self.starWarBannerTop = -600
                    self.scoreTopPadding = -350
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
