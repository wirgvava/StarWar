//
//  Monster_2.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Monster_2: View {
    @StateObject private var animationManager: AnimationManager
    
    init() {
        _animationManager = StateObject(wrappedValue: AnimationManager(images: ["Monster 2.1", "Monster 2.2"], animationDuration: 0.1))
    }
    
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
    Monster_2()
}
