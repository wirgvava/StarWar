//
//  CurrentScore.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 03.07.24.
//

import SwiftUI

struct CurrentScore: View {
    @State private var animateToggle: Bool = true
    @Binding var isAddHighScoreShown: Bool
    var score: Int
    
    var body: some View {
        HStack {
            Text("Score")
                .customFont(color: .white, size: animateToggle ? 20 : 28)
            
            Spacer()
            
            Text("\(score)")
                .customFont(color: .white, size: animateToggle ? 20 : 28)
        }
        .padding(.horizontal)
        .onAppear(){
            checkForLeaderboard()
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0).repeatForever()) {
                animateToggle.toggle()
            }
        }
    }
    
    private func checkForLeaderboard(){
        let topScores = FirestoreManager.topScores
        
        for i in 0..<min(100, topScores.count) {
            if score > topScores[i].score {
                isAddHighScoreShown = true
                break
            }
        }
    }
}
