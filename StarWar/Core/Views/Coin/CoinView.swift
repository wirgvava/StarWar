//
//  CoinView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct CoinView: View {
    @StateObject private var animationManager: AnimationManager = .init(
        images: [.coinFrontView, .coinSideView],
        animationDuration: 0.1)
    
    var size: CGFloat
   
    var body: some View {
        Image(animationManager.images[animationManager.currentImageIndex])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .onAppear(){
                animationManager.startAnimation()
            }
    }
}

#Preview {
    CoinView(size: 30)
}
