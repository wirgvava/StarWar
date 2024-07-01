//
//  HighScoreBanner.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 01.07.24.
//

import SwiftUI

struct HighScoreBanner: View {
    @Binding var topPadding: CGFloat
    @Binding var highScore: Int
    
    var body: some View {
        VStack {
            Image(.starWar)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, topPadding)
                .padding(.horizontal)
            
            HStack {
                Text("High Score")
                    .foregroundColor(.white)
                    .font(.custom("Minecraft", size: 28))
                    .padding(.top, topPadding + 80)
                
                Spacer()
                
                Text("\(highScore)")
                    .foregroundColor(.white)
                    .font(.custom("Minecraft", size: 28))
                    .padding(.top, topPadding + 80)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HighScoreBanner(topPadding: .constant(-300), highScore: .constant(19204))
}
