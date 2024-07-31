//
//  PauseView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 31.07.24.
//

import SwiftUI

struct PauseView: View {
    var body: some View {
        Image(.pause)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
    }
}

#Preview {
    PauseView()
}
