//
//  MenuButtons.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 01.07.24.
//

import SwiftUI

struct MenuButtons: View {
    @Binding var sidePadding: CGFloat
    
    var body: some View {
        HStack {
            VStack {
                Spacer()
                
                Image(.healthFull)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                
                Spacer()
                
                Image(.healthFull)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                
                Spacer()
                
                Image(.healthFull)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                
                Spacer()
            }
            
            Spacer()
            
            VStack {
                Spacer()
                
                Button(action: {
                    print("Coin tapped!")
                }) {
                    Image(.coinFrontView)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                Spacer()
                
                Button(action: {
                    print("Coin tapped!")
                }) {
                    Image(.rating)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                Spacer()
                
                Button(action: {
                    print("Settings tapped!")
                }) {
                    Image(.settings)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                Spacer()
            }
            
        }
        .padding(.init(top: 530, 
                       leading: sidePadding,
                       bottom: 0, 
                       trailing: sidePadding))
    }
}

#Preview {
    MenuButtons(sidePadding: .constant(20))
}
