//
//  AddHighScore.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 10.07.24.
//

import SwiftUI

struct AddHighScore: View {
    @State var name: String = ""
    @Binding var isAddHighScorePresented: Bool
    var score: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 70, height: 205)
                .foregroundStyle(.limeBullet)
            
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 60, height: 190)
                .foregroundStyle(.limeBullet)
                .overlay {
                    VStack(alignment: .center) {
                        Text(localized: "leaderboard.banner.header")
                            .customFont(color: .pink, size: 30)
                        
                        Text(localized: "leaderboard.banner.message")
                            .customFont(color: .space, size: 14)
                            .multilineTextAlignment(.center)
                        
                        ZStack {
                            Rectangle()
                                .frame(width: UIScreen.main.bounds.width - 100,
                                       height: 60)
                                .foregroundStyle(.white)
                            
                            Rectangle()
                                .frame(width: UIScreen.main.bounds.width - 90,
                                       height: 50)
                                .foregroundStyle(.white)
                                .overlay {
                                    TextField(NSLocalizedString("enter.name", comment: ""),
                                              text: $name)
                                        .textFieldStyle(.plain)
                                        .foregroundStyle(.space)
                                        .font(.custom("Minecraft", size: 24))
                                        .tint(.pink)
                                        .keyboardType(.alphabet)
                                        .padding(.horizontal)
                                }
                        }
                        
                        Button {
                            addNewTopScore()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: UIScreen.main.bounds.width - 100, height: 50)
                                    .foregroundStyle(.pink)
                                
                                Rectangle()
                                    .frame(width: UIScreen.main.bounds.width - 90, height: 40)
                                    .foregroundStyle(.pink)
                                    .overlay {
                                        Text(localized: "add")
                                            .customFont(color: .limeBullet, size: 24)
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
        }
    }
    
    private func addNewTopScore(){
        if !name.isEmpty {
            SoundManager.shared.play(sound: .buttonClick)
            isAddHighScorePresented = false
            FirestoreManager.addTopScore(name: name, score: score)
        }
    }
}

#Preview {
    AddHighScore(isAddHighScorePresented: .constant(true),
                 score: 20)
}
