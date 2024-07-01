//
//  Monster_3.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Monster_3: View {
    @StateObject private var animationManager: AnimationManager = .init(
        images: [.monster31, .monster32],
        animationDuration: 0.1)
    
    var body: some View {
        Image(animationManager.images[animationManager.currentImageIndex])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .onAppear(){
                animationManager.startAnimation()
            }
    }
}

#Preview {
    Monster_3()
}
