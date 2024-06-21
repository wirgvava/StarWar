//
//  Ship_4.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Ship_4: View {
    @StateObject private var animationManager: AnimationManager
    
    init() {
        _animationManager = StateObject(wrappedValue: AnimationManager(images: ["Ship 4.1", "Ship 4.2", "Ship 4.3"]))
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
    Ship_4()
}
