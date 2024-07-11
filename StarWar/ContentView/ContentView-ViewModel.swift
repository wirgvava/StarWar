//
//  ContentView-ViewModel.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 09.07.24.
//

import SwiftUI

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var highScoreBannerTopPadding: CGFloat = -300
        private(set) var currentScoreShown = false
        private(set) var scoreTopPadding: CGFloat = -600
        private(set) var menuButtonsSidePadding: CGFloat = 20
        var isPlayable: Bool = true
        var isPlaying: Bool = false
        var gameOver: Bool = false
        var shipType: Int = 1
        var bullets: [Bullet] = []
        var score: Int = 0
        var shipPosition: CGPoint = CGPoint(
            x: UIScreen.main.bounds.width / 2,
            y: (UIScreen.main.bounds.height / 2) - 50)
        
        // Navigation
        var isMarketShown: Bool = false
        var isLeaderboardShown: Bool = false
        var isSettingsShown: Bool = false
        var isAddHighScoreShown: Bool = false
        
        // ShipAnimation
        var shipIsMovingLeft: Bool = false
        var shipIsMovingRight: Bool = false
        
//      MARK: - Methods
        func isPlayingMode(){
            withAnimation(.snappy) {
                self.highScoreBannerTopPadding = -600
                self.scoreTopPadding = -350
                self.menuButtonsSidePadding = -40
                self.currentScoreShown = false
                self.score = 0
            }
        }
        
        func notPlayingMode(){
            withAnimation(.snappy) {
                self.currentScoreShown = true
                self.highScoreBannerTopPadding = -300
                self.scoreTopPadding = -600
                self.menuButtonsSidePadding = 20
            }
        }
    }
}
