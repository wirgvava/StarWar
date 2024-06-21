//
//  Ship_5.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Ship_5: View {
    @StateObject private var animationManager: AnimationManager
    
    init() {
        _animationManager = StateObject(wrappedValue: AnimationManager(images: ["Ship 5.1", "Ship 5.2", "Ship 5.3", "Ship 5.4", "Ship 5.5", "Ship 5.6", "Ship 5.7"]))
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
    Ship_5()
}
