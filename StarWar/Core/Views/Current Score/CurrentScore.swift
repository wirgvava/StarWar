//
//  CurrentScore.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 03.07.24.
//

import SwiftUI

struct CurrentScore: View {
    @State private var animateToggle: Bool = true
    var score: Int
    
    var body: some View {
        HStack {
            Text(localized: "score")
                .customFont(color: .white, size: animateToggle ? 20 : 28)
            
            Spacer()
            
            Text("\(score)")
                .customFont(color: .white, size: animateToggle ? 20 : 28)
        }
        .padding(.horizontal)
        .onAppear(){
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0).repeatForever()) {
                animateToggle.toggle()
            }
        }
    }
}
