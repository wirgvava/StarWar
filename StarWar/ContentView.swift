//
//  ContentView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct ContentView: View {
    @State private var isPlayable: Bool = true
    @State private var isPlaying: Bool = false
    @State private var gameOver: Bool = false
    @State private var shipType: Int = 1
    @State private var currentScoreShown = false
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
            
            if currentScoreShown {
                CurrentScore(score: $score)
                    .padding(.top, highScoreBannerTopPadding + 120)
            }
            
            MenuButtons(sidePadding: $menuButtonsSidePadding, gameOver: $gameOver)
            
            MovingMonsters(bullets: $bullets, isPlayable: $isPlayable, isPlaying: $isPlaying, gameOver: $gameOver, shipType: $shipType, shipPosition: $shipPosition, score: $score)
            
            Ship_1(shipType: $shipType, isPlayable: $isPlayable, isPlaying: $isPlaying, gameOver: $gameOver, shipPosition: $shipPosition, bullets: $bullets)
                .scaleEffect(isPlaying ? 1.0 : 1.8)
                .animation(.easeOut, value: isPlaying)
            
            InGameInfo(score: $score, scoreTopPadding: $scoreTopPadding)
        }
        .onChange(of: isPlaying) { _, newValue in
            if newValue {
                withAnimation(.snappy) {
                    self.highScoreBannerTopPadding = -600
                    self.scoreTopPadding = -350
                    self.menuButtonsSidePadding = -40
                    self.currentScoreShown = false
                    self.score = 0
                }
            } else {
                withAnimation(.snappy) {
                    self.currentScoreShown = true
                    self.highScoreBannerTopPadding = -300
                    self.scoreTopPadding = -600
                    self.menuButtonsSidePadding = 20
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
