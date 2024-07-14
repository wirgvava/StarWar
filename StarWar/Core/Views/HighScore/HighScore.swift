//
//  HighScore.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 01.07.24.
//

import SwiftUI

struct HighScore: View {
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
    }
}
