//
//  Monster_1.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Monster_1: View {
    @StateObject private var animationManager: AnimationManager = .init(
        images: [.monster11, .monster12],
        animationDuration: 0.1)
    
    var body: some View {
        Image(animationManager.images[animationManager.currentImageIndex])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 70, height: 70)
            .onAppear(){
                animationManager.startAnimation()
            }
    }
}

#Preview {
    Monster_1()
}
