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
        var appStorageManager = AppStorageManager.shared
        private(set) var highScoreBannerTopPadding: CGFloat = -300
        private(set) var currentScorePresented = false
        private(set) var scoreTopPadding: CGFloat = -600
        private(set) var menuButtonsSidePadding: CGFloat = 20
        var isPlayable: Bool = true
        var isPlaying: Bool = false
        var isPaused: Bool = false
        var gameOver: Bool = false
        var shipType: Int = AppStorageManager.shared.shipType
        var shipIsUnlocked: Bool = true
        var bullets: [Bullet] = []
        var score: Int = 0
        var collectedCoins: Int = 0
        var shipPosition: CGPoint = CGPoint(
            x: UIScreen.main.bounds.width / 2,
            y: (UIScreen.main.bounds.height / 2) - 50)
        
        // Navigation
        var isWatchAdViewPresented: Bool = false
        var isMarketPresented: Bool = false
        var isLeaderboardPresented: Bool = false
        var isSettingsPresented: Bool = false
        var isAddHighScorePresented: Bool = false
        
        // ShipAnimation
        var shipIsMovingLeft: Bool = false
        
        // MARK: - Methods
        func onApear(){
            SoundManager.shared.play(sound: .soundtrack, numberOfLoops: -1)
            gameCenterAuthenticateAndFetchingData()
        }
        
        func isPlayingMode(){
            withAnimation(.snappy) {
                self.highScoreBannerTopPadding = -600
                self.scoreTopPadding = -350
                self.menuButtonsSidePadding = -40
                self.currentScorePresented = false
                self.score = 0
                self.collectedCoins = 0
                SoundManager.shared.play(sound: .gameBgSound, numberOfLoops: -1)
            }
        }
        
        func notPlayingMode(){
            withAnimation(.snappy) {
                self.currentScorePresented = true
                self.highScoreBannerTopPadding = -300
                self.scoreTopPadding = -600
                self.menuButtonsSidePadding = 20
                SoundManager.shared.play(sound: .soundtrack, numberOfLoops: -1)
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
                    self.appStorageManager.money = gameData.money
                    self.appStorageManager.userHighScore = gameData.userHighScore
                    self.appStorageManager.unlockedShips = gameData.unlockedShips
                }
            }
        }
        
        // MARK: - The Ship
        @ViewBuilder
        func ship(shipType: Binding<Int>,
                  isPlayable: Binding<Bool>,
                  isPlaying: Binding<Bool>,
                  isPaused: Binding<Bool>,
                  gameOver: Binding<Bool>,
                  shipPosition: Binding<CGPoint>,
                  bullets: Binding<[Bullet]>,
                  isMovingLeft: Bool) -> some View {
            switch self.shipType {
            case 1:     Ship_1(shipType: shipType,
                               isPlayable: isPlayable,
                               isPlaying: isPlaying,
                               isPaused: isPaused, 
                               gameOver: gameOver,
                               shipPosition: shipPosition,
                               bullets: bullets,
                               isMovingLeft: isMovingLeft)
            case 2:     Ship_2(shipType: shipType,
                               isPlayable: isPlayable,
                               isPlaying: isPlaying,
                               isPaused: isPaused,
                               gameOver: gameOver,
                               shipPosition: shipPosition,
                               bullets: bullets,
                               isMovingLeft: isMovingLeft)
            case 3:     Ship_3(shipType: shipType,
                               isPlayable: isPlayable,
                               isPlaying: isPlaying,
                               isPaused: isPaused,
                               gameOver: gameOver,
                               shipPosition: shipPosition,
                               bullets: bullets,
                               isMovingLeft: isMovingLeft)
            case 4:     Ship_4(shipType: shipType,
                               isPlayable: isPlayable,
                               isPlaying: isPlaying,
                               isPaused: isPaused,
                               gameOver: gameOver,
                               shipPosition: shipPosition,
                               bullets: bullets,
                               isMovingLeft: isMovingLeft)
            case 5:     Ship_5(shipType: shipType,
                               isPlayable: isPlayable,
                               isPlaying: isPlaying,
                               isPaused: isPaused,
                               gameOver: gameOver,
                               shipPosition: shipPosition,
                               bullets: bullets,
                               isMovingLeft: isMovingLeft)
            case 6:     Ship_6(shipType: shipType,
                               isPlayable: isPlayable,
                               isPlaying: isPlaying,
                               isPaused: isPaused,
                               gameOver: gameOver,
                               shipPosition: shipPosition,
                               bullets: bullets,
                               isMovingLeft: isMovingLeft)
            default:    Ship_1(shipType: shipType,
                               isPlayable: isPlayable,
                               isPlaying: isPlaying,
                               isPaused: isPaused,
                               gameOver: gameOver,
                               shipPosition: shipPosition,
                               bullets: bullets,
                               isMovingLeft: isMovingLeft)
            }
        }
    }
}
