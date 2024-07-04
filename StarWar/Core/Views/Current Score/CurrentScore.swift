//
//  CurrentScore.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 03.07.24.
//

import SwiftUI

struct CurrentScore: View {
    @Binding var score: Int
    @State private var animateToggle: Bool = true
    
    var body: some View {
        HStack {
            Text("Score")
                .foregroundColor(.white)
                .font(.custom("Minecraft", size: animateToggle ? 20 : 28))
            
            Spacer()
            
            Text("\(score)")
                .foregroundColor(.white)
                .font(.custom("Minecraft", size: animateToggle ? 20 : 28))
        }
        .padding(.horizontal)
        .onAppear(){
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0).repeatForever()) {
                animateToggle.toggle()
            }
        }
    }
}
