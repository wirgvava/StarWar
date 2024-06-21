//
//  Ship_6.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Ship_6: View {
    @StateObject private var animationManager: AnimationManager
    
    init() {
        _animationManager = StateObject(wrappedValue: AnimationManager(images: ["Ship 6.1", "Ship 6.2", "Ship 6.3", "Ship 6.4", "Ship 6.5", "Ship 6.6", "Ship 6.7", "Ship 6.8"]))
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
    Ship_6()
}
