//
//  HighScore.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 01.07.24.
//

import SwiftUI

struct HighScore: View {
    @ObservedObject var appStorageManager = AppStorageManager.shared
    @Binding var isAddHighScorePresented: Bool
    var isPlaying: Bool
    var score: Int
    var topPadding: CGFloat
    
    var body: some View {
        HStack {
            Text(localized: "high.score")
                .customFont(color: .white, size: 28)
                .padding(.top, topPadding + 80)
            
            Spacer()
            
            Text("\(appStorageManager.userHighScore)")
                .customFont(color: .white, size: 28)
                .padding(.top, topPadding + 80)
        }
        .padding(.horizontal)
        .onChange(of: isPlaying) { _, newValue in
            if !newValue {
                checkForLeaderboard()
                updateUserHighScore()
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
    
    private func updateUserHighScore(){
        guard score > appStorageManager.userHighScore else { return }
        appStorageManager.userHighScore = score
        GameCenterManager.shared.updateData()
    }
}
