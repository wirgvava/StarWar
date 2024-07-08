//
//  InGameInfo.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 01.07.24.
//

import SwiftUI

struct InGameInfo: View {
    @Binding var score: Int
    @Binding var scoreTopPadding: CGFloat
    
    var body: some View {
        HStack(alignment: .top) {
            HStack {
                healthView(heartSize: 30)
            }
            
            Spacer()
            
            Text("Score\n\(score)")
                .font(.custom("Minecraft", fixedSize: 24))
                .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
        }
        .padding(.horizontal)
        .padding(.top, scoreTopPadding)
    }
}

#Preview {
    InGameInfo(
        score: .constant(1920),
        scoreTopPadding: .constant(-600)
    )
}
