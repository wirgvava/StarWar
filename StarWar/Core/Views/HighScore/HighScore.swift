//
//  HighScore.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 01.07.24.
//

import SwiftUI

struct HighScore: View {
    @Binding var isAddHighScorePresented: Bool
    var isPlaying: Bool
    var score: Int
    var topPadding: CGFloat
    
    var body: some View {
        HStack {
            Text("High Score")
                .customFont(color: .white, size: 28)
                .padding(.top, topPadding + 80)
            
            Spacer()
            
            Text("\(AppStorageManager.userHighScore)")
                .customFont(color: .white, size: 28)
                .padding(.top, topPadding + 80)
        }
        .padding(.horizontal)
        .onChange(of: score) { _, newValue in
            if newValue > AppStorageManager.userHighScore {
                AppStorageManager.userHighScore = newValue
                GameCenterManager.shared.save(
                    data: GameData(userHighScore: newValue,
                                   money: AppStorageManager.money,
                                   unlockedShips: AppStorageManager.unlockedShips))
            }
        }
        .onChange(of: isPlaying) { _, newValue in
            if !newValue {
                checkForLeaderboard()
            }
        }
    }
    
    private func checkForLeaderboard(){
        let topScores = FirestoreManager.topScores
        
        for i in 0..<min(100, topScores.count) {
            if score > topScores[i].score {
                isAddHighScorePresented = true
                break
            }
        }
    }
}
