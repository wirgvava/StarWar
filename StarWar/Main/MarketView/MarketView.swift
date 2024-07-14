//
//  MarketView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 13.07.24.
//

import SwiftUI

struct MarketView: View {
    @Binding var isUnlocked: Bool
    @Binding var shipType: Int
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
                    guard shipType != 1 else { return }
                    shipType -= 1
                } label: {
                    Image(.left)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                }
                
                Spacer()
                
                Button {
                    guard shipType != 6 else { return }
                    shipType += 1
                } label: {
                    Image(.right)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                }
            }
            .padding(.bottom, 100)
            
            // Buy button
            Button {
                guard !isUnlocked else { return }
                // TODO: Buy logic
                print("BUY")
            } label: {
                ZStack {
                    Rectangle()
                        .frame(width: 150, height: 50)
                        .foregroundStyle(isUnlocked ? .clear : .yellow)
                    
                    Rectangle()
                        .frame(width: 140, height: 60)
                        .foregroundStyle(isUnlocked ? .clear : .yellow)
                    
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
                        Text(isUnlocked ? "" : " \(price)")
                            .customFont(color: .black, size: 24)
                    }
                }
            }
        }
        .padding(.horizontal)
        .onAppear() {
            isUnlocked = AppStorageManager.unlockedShips.contains(shipType) ? true : false
        }
        .onChange(of: shipType) { _, newValue in
            isUnlocked = AppStorageManager.unlockedShips.contains(newValue) ? true : false
            
            switch newValue {
            case 2:     price = 350
            case 3:     price = 450
            case 4:     price = 650
            case 5:     price = 850
            case 6:     price = 1000
            default:    price = 150
            }
        }
    }
    
    
    
}
