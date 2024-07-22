//
//  DragToPlayView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 22.07.24.
//

import SwiftUI

struct DragToPlayView: View {
    @State private var animate: Bool = false
    var isPlaying: Bool
    
    var body: some View {
        if !isPlaying && AppStorageManager.shared.pointOfHealth != 0 {
            VStack {
                Spacer()
                Spacer()
                Text(localized: "drag.to.play")
                    .customFont(color: .white, size: animate ? 26 : 30)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .onAppear(){
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0).repeatForever()) {
                    animate.toggle()
                }
            }
        }
    }
}
