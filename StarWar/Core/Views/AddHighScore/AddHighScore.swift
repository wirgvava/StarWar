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
                .frame(width: UIScreen.main.bounds.width - 115, height: 215)
                .foregroundStyle(.limeBullet)
            
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 100, height: 200)
                .foregroundStyle(.limeBullet)
                .overlay {
                    VStack(alignment: .center) {
                        Text("Congrats")
                            .customFont(color: .pink, size: 30)
                        
                        Text("Your score is in the Leaderboard")
                            .customFont(color: .space, size: 16)
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 250, height: 60)
                                .foregroundStyle(.white)
                            
                            Rectangle()
                                .frame(height: 50)
                                .foregroundStyle(.white)
                                .overlay {
                                    TextField("Enter Name", text: $name)
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
                                    .frame(width: 90, height: 60)
                                    .foregroundStyle(.pink)
                                
                                Rectangle()
                                    .frame(width: 100, height: 50)
                                    .foregroundStyle(.pink)
                                    .overlay {
                                        Text("Add")
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
            isAddHighScorePresented = false
            FirestoreManager.addTopScore(name: name, score: score)
        }
    }
}

#Preview {
    AddHighScore(isAddHighScorePresented: .constant(true),
                 score: 20)
}
