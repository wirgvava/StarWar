//
//  Ship_1.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Ship_1: View {
    @StateObject private var animationManager: AnimationManager
    
    init() {
        _animationManager = StateObject(wrappedValue: AnimationManager(images: ["Ship 1.1", "Ship 1.2", "Ship 1.3"]))
    }
    
    var body: some View {
        Image(animationManager.images[animationManager.currentImageIndex])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear(){
                animationManager.startAnimation()
            }
    }
}

#Preview {
    Ship_1()
}
