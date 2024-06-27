//
//  ContentView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

struct ContentView: View {
    @State private var shipPosition: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
    @State private var starWarBannerTop: CGFloat = -300
    @State private var isPlaying: Bool = false
    
    var body: some View {
        ZStack {            
            Stars(isPlaying: $isPlaying)  
            
            VStack {
                Image("StarWar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, starWarBannerTop)
                    .padding(.horizontal)
            }
            
            Ship_1(isPlaying: $isPlaying, shipPosition: $shipPosition)
        }
        .onChange(of: isPlaying) { _, newValue in
            if newValue {
                withAnimation(.snappy) {
                    self.starWarBannerTop = -600
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
