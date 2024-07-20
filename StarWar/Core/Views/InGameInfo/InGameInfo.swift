//
//  InGameInfo.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 01.07.24.
//

import SwiftUI

struct InGameInfo: View {
    var score: Int
    var scoreTopPadding: CGFloat
    
    var body: some View {
        HStack(alignment: .top) {
            HStack {
                healthView(heartSize: 30)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(localized: "score")
                    .customFont(color: .white, size: 24)
                    .multilineTextAlignment(.trailing)
                Text("\(score)")
                    .customFont(color: .white, size: 24)
                    .multilineTextAlignment(.trailing)
            }
        }
        .padding(.horizontal)
        .padding(.top, scoreTopPadding)
    }
}

#Preview {
    InGameInfo(
        score: 1920,
        scoreTopPadding: -600
    )
}
