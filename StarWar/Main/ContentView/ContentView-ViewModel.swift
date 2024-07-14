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
        var shipIsUnlocked: Bool = true
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
        
        // MARK: - Game Center
        func gameCenterAuthenticateAndFetchingData(){
            GameCenterManager.shared.authenticate() { isAuthenticated in
                if isAuthenticated {
                    self.fetchData()
                }
            }
        }
        
        func fetchData(){
            GameCenterManager.shared.fetchSavedData { gameData in
                if let gameData = gameData {
                    AppStorageManager.money = gameData.money
                    AppStorageManager.userHighScore = gameData.userHighScore
                    AppStorageManager.unlockedShips = gameData.unlockedShips
                }
            }
        }
        
        // MARK: -
        @ViewBuilder
        func ship(shipType: Binding<Int>,
                  isPlayable: Binding<Bool>,
                  isPlaying: Binding<Bool>,
                  gameOver: Binding<Bool>,
                  shipPosition: Binding<CGPoint>,
                  bullets: Binding<[Bullet]>,
                  isMovingLeft: Bool) -> some View {
            switch self.shipType {
            case 1:     Ship_1(shipType: shipType,
                               isPlayable: isPlayable,
                               isPlaying: isPlaying,
                               gameOver: gameOver,
                               shipPosition: shipPosition,
                               bullets: bullets,
                               isMovingLeft: isMovingLeft)
            case 2:     Ship_2(shipType: shipType,
                               isPlayable: isPlayable,
                               isPlaying: isPlaying,
                               gameOver: gameOver,
                               shipPosition: shipPosition,
                               bullets: bullets,
                               isMovingLeft: isMovingLeft)
            case 3:     Ship_3(shipType: shipType,
                               isPlayable: isPlayable,
                               isPlaying: isPlaying,
                               gameOver: gameOver,
                               shipPosition: shipPosition,
                               bullets: bullets,
                               isMovingLeft: isMovingLeft)
            case 4:     Ship_4(shipType: shipType,
                               isPlayable: isPlayable,
                               isPlaying: isPlaying,
                               gameOver: gameOver,
                               shipPosition: shipPosition,
                               bullets: bullets,
                               isMovingLeft: isMovingLeft)
            case 5:     Ship_5(shipType: shipType,
                               isPlayable: isPlayable,
                               isPlaying: isPlaying,
                               gameOver: gameOver,
                               shipPosition: shipPosition,
                               bullets: bullets,
                               isMovingLeft: isMovingLeft)
            case 6:     Ship_6(shipType: shipType,
                               isPlayable: isPlayable,
                               isPlaying: isPlaying,
                               gameOver: gameOver,
                               shipPosition: shipPosition,
                               bullets: bullets,
                               isMovingLeft: isMovingLeft)
            default:    Ship_1(shipType: shipType,
                               isPlayable: isPlayable,
                               isPlaying: isPlaying,
                               gameOver: gameOver,
                               shipPosition: shipPosition,
                               bullets: bullets,
                               isMovingLeft: isMovingLeft)
            }
        }
    }
}
