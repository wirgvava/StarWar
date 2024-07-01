//
//  Coin.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Coin: View {
    @StateObject private var animationManager: AnimationManager = .init(
        images: [.coinFrontView, .coinSideView],
        animationDuration: 0.1)
   
    var body: some View {
        Image(animationManager.images[animationManager.currentImageIndex])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)
            .onAppear(){
                animationManager.startAnimation()
            }
    }
}

#Preview {
    Coin()
}
