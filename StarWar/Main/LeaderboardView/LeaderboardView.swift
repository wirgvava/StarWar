//
//  LeaderboardView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 09.07.24.
//

import SwiftUI

struct LeaderboardView: View {
    @ObservedObject var firestoreManager = FirestoreManager.shared
    
    var body: some View {
        ZStack {
            Text(localized: "leaderboard")
                .customFont(color: .white, size: 40)
                .padding(.bottom, 350)
            
            ScrollView {
                ForEach(Array(firestoreManager.topScores.prefix(100).enumerated()),
                        id: \.element) { index, user in
                    HStack {
                        Group {
                            Text("\(index + 1)")
                                .customFont(color: .white, size: 24)

                            Text(user.name)
                                .customFont(color: .white, size: 24)
                        }
                        
                        Spacer()
                        Text("\(user.score)")
                            .customFont(color: .white, size: 24)
                    }
                    .padding(.vertical, 8)
                }
                .padding(.horizontal)
            }
            .padding(.top, 80)
            .frame(height: 450)
        }
    }
}
