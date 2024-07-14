//
//  MarketView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 13.07.24.
//

import SwiftUI

struct MarketView: View {
    
    @State private var isUnlocked: Bool = false
    @State private var price: Int = 250
    
    var body: some View {
        VStack {
            // Header with amount of money
            HStack {
                Text("Market")
                    .customFont(color: .white, size: 40)
                
                Spacer()
                
                Image(.coinFrontView)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                    .padding(.horizontal)
                
                Text("\(AppStorageManager.money)")
                    .customFont(color: .white, size: 30)
            }
            .padding(.bottom, 100)
            
            // Switch The Ships buttons
            HStack {
                Button {
                    print("Left")
                } label: {
                    Image(.left)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                }
                
                Spacer()
                
                Button {
                    print("Right")
                } label: {
                    Image(.right)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                }
            }
            .padding(.bottom, 100)
            
            // Select / Buy buttons
            Button {
                print("Selected")
            } label: {
                ZStack {
                    Rectangle()
                        .frame(width: 150, height: 50)
                        .foregroundStyle(isUnlocked ? .white : .yellow)
                    
                    Rectangle()
                        .frame(width: 140, height: 60)
                        .foregroundStyle(isUnlocked ? .white : .yellow)
                    
                    HStack {
                        if !isUnlocked {
                            ZStack {
                                Image(.coinFrontView)
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(.black)
                                    .frame(width: 35, height: 35)
                                Image(.coinFrontView)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                            }
                            
                        }
                        Text(isUnlocked ? "Select" : " \(price)")
                            .customFont(color: .black, size: 24)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    MarketView()
}
