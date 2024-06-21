//
//  Ship_3.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct Ship_3: View {
    @StateObject private var animationManager: AnimationManager
    
    init() {
        _animationManager = StateObject(wrappedValue: AnimationManager(images: ["Ship 3.1", "Ship 3.2", "Ship 3.3", "Ship 3.4", "Ship 3.5"]))
    }
    
    var body: some View {
        Image(animationManager.images[animationManager.currentImageIndex])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80, height: 80)
            .onAppear(){
                animationManager.startAnimation()
            }
    }
}

#Preview {
    Ship_3()
}
