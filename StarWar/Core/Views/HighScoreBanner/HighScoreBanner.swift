//
//  HighScoreBanner.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 01.07.24.
//

import SwiftUI

struct HighScoreBanner: View {
    var score: Int
    var topPadding: CGFloat
    
    var body: some View {
        VStack {
            Image(.starWar)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, topPadding)
                .padding(.horizontal)
            
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
        }
        .onChange(of: score) { _, newValue in
            if newValue > AppStorageManager.userHighScore {
                AppStorageManager.userHighScore = newValue
            }
        }
    }
}

#Preview {
    HighScoreBanner(score: 404, topPadding: -300)
}
