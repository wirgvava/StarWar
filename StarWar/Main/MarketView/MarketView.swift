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
                    previousShip()
                } label: {
                    Image(.left)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                }
                
                Spacer()
                
                Button {
                    nextShip()
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
                buyTheShip()
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
            switchPrices(by: newValue)
        }
    }
    
    //  MARK: - Methods
    private func switchPrices(by shipType: Int){
        switch shipType {
        case 2:     price = 550
        case 3:     price = 850
        case 4:     price = 1000
        case 5:     price = 1500
        case 6:     price = 2000
        default:    price = 550
        }
    }
    
    // Actions
    private func previousShip(){
        guard shipType != 1 else { return }
        SoundManager.shared.play(sound: .buttonClick)
        shipType -= 1
    }
    
    private func nextShip(){
        guard shipType != 6 else { return }
        SoundManager.shared.play(sound: .buttonClick)
        shipType += 1
    }
    
    private func buyTheShip(){
        guard !isUnlocked else { return }
        guard AppStorageManager.money >= price else { return }
        SoundManager.shared.play(sound: .buy)
        AppStorageManager.money -= price
        AppStorageManager.unlockedShips.append(shipType)
        isUnlocked = true
        GameCenterManager.shared.save(
            data: GameData(userHighScore: AppStorageManager.userHighScore,
                           money: AppStorageManager.money,
                           unlockedShips: AppStorageManager.unlockedShips))
    }
}
