//
//  Monster_4.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Monster_4: View {
    @StateObject private var animationManager: AnimationManager
    
    init() {
        _animationManager = StateObject(wrappedValue: AnimationManager(images: ["Monster 4.1", "Monster 4.2"], animationDuration: 0.1))
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
    Monster_4()
}
