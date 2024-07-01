//
//  ContentView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct ContentView: View {
    @State private var isPlaying: Bool = false
    @State private var bullets: [Bullet] = []
    @State private var score: Int = 0
    @State private var highScore: Int = 18404
    @State private var scoreTopPadding: CGFloat = -600
    @State private var highScoreBannerTopPadding: CGFloat = -300
    @State private var menuButtonsSidePadding: CGFloat = 20
    @State private var shipPosition: CGPoint = CGPoint(
        x: UIScreen.main.bounds.width / 2,
        y: (UIScreen.main.bounds.height / 2) - 50)
    
    var body: some View {
        ZStack {     
            Stars(isPlaying: $isPlaying)
                .scaleEffect(isPlaying ? 1.0 : 2.0)
                .animation(.easeOut, value: isPlaying)
         
            HighScoreBanner(topPadding: $highScoreBannerTopPadding, highScore: $highScore)
            
            MenuButtons(sidePadding: $menuButtonsSidePadding)
            
            Ship_1(isPlaying: $isPlaying, shipPosition: $shipPosition, bullets: $bullets)
                .scaleEffect(isPlaying ? 1.0 : 1.8)
                .animation(.easeOut, value: isPlaying)
            
            MovingMonsters(bullets: $bullets, isPlaying: $isPlaying, score: $score)
            
            InGameInfo(score: $score, scoreTopPadding: $scoreTopPadding)
        }
        .onChange(of: isPlaying) { _, newValue in
            if newValue {
                withAnimation(.snappy) {
                    self.highScoreBannerTopPadding = -600
                    self.scoreTopPadding = -350
                    self.menuButtonsSidePadding = -40
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
