//
//  MeteorView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 11.07.24.
//

import SwiftUI

struct MeteorView: View {
    @StateObject private var animationManager: AnimationManager = .init(
        images: [.meteor1, .meteor2, .meteor3],
        animationDuration: 0.04)
    
    var size: CGFloat
   
    var body: some View {
        Image(animationManager.images[animationManager.currentImageIndex])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: size)
            .onAppear(){
                animationManager.startAnimation()
            }
    }
}

#Preview {
    MeteorView(size: 200)
}
