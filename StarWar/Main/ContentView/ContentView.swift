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
            
            HighScoreBanner(score: viewModel.score,
                            topPadding: viewModel.highScoreBannerTopPadding)
            
            if viewModel.currentScoreShown {
                CurrentScore(isAddHighScoreShown: $viewModel.isAddHighScoreShown,
                             score: viewModel.score)
                .padding(.top, viewModel.highScoreBannerTopPadding + 120)
            }
            
            if viewModel.isLeaderboardShown {
                withAnimation {
                    LeaderboardView()
                }
            }
            
            if viewModel.isMarketShown {
                withAnimation {
                    MarketView()
                }
            }
            
            MenuButtons(shipIsMovingLeft: $viewModel.shipIsMovingLeft,
                        shipIsMovingRight: $viewModel.shipIsMovingRight,
                        isMarketShown: $viewModel.isMarketShown,
                        isLeaderboardShown: $viewModel.isLeaderboardShown,
                        isSettingsShown: $viewModel.isSettingsShown,
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
                        shipType: viewModel.shipType)
            
            MovingMeteors(isPlayable: $viewModel.isPlayable,
                          isPlaying: $viewModel.isPlaying,
                          gameOver: $viewModel.gameOver,
                          shipPosition: $viewModel.shipPosition,
                          shipType: viewModel.shipType)
            
            Ship_1(shipType: $viewModel.shipType,
                   isPlayable: $viewModel.isPlayable,
                   isPlaying: $viewModel.isPlaying,
                   gameOver: $viewModel.gameOver,
                   shipPosition: $viewModel.shipPosition,
                   bullets: $viewModel.bullets,
                   isMovingLeft: viewModel.shipIsMovingLeft,
                   isMovingRight: viewModel.shipIsMovingRight)
            .scaleEffect(viewModel.isPlaying ? 1.0 : 1.8)
            .animation(.easeOut, value: viewModel.isPlaying)
            
            InGameInfo(score: viewModel.score,
                       scoreTopPadding: viewModel.scoreTopPadding)
            
            if viewModel.isAddHighScoreShown {
                AddHighScore(isAddHighScoreShown: $viewModel.isAddHighScoreShown,
                             score: viewModel.score)
            }
        }
        .onChange(of: viewModel.isPlaying) { _, newValue in
            if newValue {
                viewModel.isPlayingMode()
            } else {
                viewModel.notPlayingMode()
            }
        }
        .onAppear() {
            viewModel.gameCenterAuthenticateAndFetchingData()
        }
    }
}

#Preview {
    ContentView()
}
