//
//  Ship_2.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Ship_2: View {
    @StateObject private var animationManager: AnimationManager
    
    init() {
        _animationManager = StateObject(wrappedValue: AnimationManager(images: ["Ship 2.1", "Ship 2.2", "Ship 2.3", "Ship 2.4", "Ship 2.5", "Ship 2.6"]))
    }
    
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
    Ship_2()
}
