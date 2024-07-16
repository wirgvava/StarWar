//
//  ContentView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Stars(isPlaying: viewModel.isPlaying)
                .scaleEffect(viewModel.isPlaying ? 1.0 : 2.0)
                .animation(.easeOut, value: viewModel.isPlaying)
            
            StarWarBanner(topPadding: viewModel.highScoreBannerTopPadding)
            
            if !viewModel.isMarketPresented && !viewModel.isLeaderboardPresented && !viewModel.isSettingsPresented {
                HighScore(isAddHighScorePresented: $viewModel.isAddHighScorePresented,
                          isPlaying: viewModel.isPlaying,
                          score: viewModel.score,
                          topPadding: viewModel.highScoreBannerTopPadding)
            }
            
            if viewModel.currentScorePresented && !viewModel.isMarketPresented && !viewModel.isLeaderboardPresented && !viewModel.isSettingsPresented {
                CurrentScore(score: viewModel.score)
                .padding(.top, viewModel.highScoreBannerTopPadding + 120)
            }
            
            if viewModel.isLeaderboardPresented {
                withAnimation {
                    LeaderboardView()
                }
            }
            
            if viewModel.isMarketPresented {
                withAnimation {
                    MarketView(isUnlocked: $viewModel.shipIsUnlocked,
                               shipType: $viewModel.shipType)
                }
            }
            
            MenuButtons(isPlayable: $viewModel.isPlayable,
                        shipIsMovingLeft: $viewModel.shipIsMovingLeft,
                        shipIsUnlocked: $viewModel.shipIsUnlocked,
                        isMarketPresented: $viewModel.isMarketPresented,
                        isLeaderboardPresented: $viewModel.isLeaderboardPresented,
                        isSettingsPresented: $viewModel.isSettingsPresented,
                        isAddHighScorePresented: $viewModel.isAddHighScorePresented,
                        isWatchAdViewPresented: $viewModel.isWatchAdViewPresented,
                        sidePadding: viewModel.menuButtonsSidePadding,
                        gameOver: viewModel.gameOver)
            
            MovingMonsters(bullets: $viewModel.bullets,
                           isPlayable: $viewModel.isPlayable,
                           isPlaying: $viewModel.isPlaying,
                           gameOver: $viewModel.gameOver,
                           shipPosition: $viewModel.shipPosition,
                           score: $viewModel.score,
                           shipType: viewModel.shipType)
            
            MovingCoins(isPlaying: $viewModel.isPlaying,
                        shipPosition: $viewModel.shipPosition,
                        collectedCoins: $viewModel.collectedCoins, 
                        shipType: viewModel.shipType)
            
            MovingMeteors(isPlayable: $viewModel.isPlayable,
                          isPlaying: $viewModel.isPlaying,
                          gameOver: $viewModel.gameOver,
                          shipPosition: $viewModel.shipPosition,
                          shipType: viewModel.shipType)
            
            viewModel.ship(shipType: $viewModel.shipType,
                           isPlayable: $viewModel.isPlayable,
                           isPlaying: $viewModel.isPlaying,
                           gameOver: $viewModel.gameOver,
                           shipPosition: $viewModel.shipPosition,
                           bullets: $viewModel.bullets,
                           isMovingLeft: viewModel.shipIsMovingLeft)
            .scaleEffect(viewModel.isPlaying ? 1.0 : 1.8)
            .animation(.easeOut, value: viewModel.isPlaying)
            
            InGameInfo(score: viewModel.score,
                       scoreTopPadding: viewModel.scoreTopPadding)
            
            if viewModel.isAddHighScorePresented {
                AddHighScore(isAddHighScorePresented: $viewModel.isAddHighScorePresented,
                             score: viewModel.score)
            }
            
            if viewModel.isWatchAdViewPresented && viewModel.currentScorePresented {
                WatchAdView(isWatchAdViewPresented: $viewModel.isWatchAdViewPresented,
                            collectedCoins: viewModel.collectedCoins)
            }
        }
        .onAppear() {
            SoundManager.shared.play(sound: .bgSound, numberOfLoops: -1)
            viewModel.gameCenterAuthenticateAndFetchingData()
        }
        .onChange(of: viewModel.isPlaying) { _, newValue in
            if newValue {
                viewModel.isPlayingMode()
            } else {
                viewModel.notPlayingMode()
            }
        }
        .onChange(of: viewModel.collectedCoins) { _, newValue in
            if newValue > 0 {
                viewModel.isWatchAdViewPresented = true
            }
        }
    }
}

#Preview {
    ContentView()
}
