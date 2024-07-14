//
//  StarWarBanner.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 14.07.24.
//

import SwiftUI

struct StarWarBanner: View {
    var topPadding: CGFloat

    var body: some View {
        Image(.starWar)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.top, topPadding)
            .padding(.horizontal)
    }
}
