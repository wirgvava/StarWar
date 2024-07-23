//
//  MovingCoins.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 11.07.24.
//

import SwiftUI

struct MovingCoins: View {
    @ObservedObject var appStorageManager = AppStorageManager.shared
    @Binding var isPlaying: Bool
    @Binding var shipPosition: CGPoint
    @Binding var collectedCoins: Int
    @State private var coins = [Coin]()
    @State private var intervalBetweenCoins = 0

    var body: some View {
        ZStack {
            ForEach(coins) { coin in
                CoinView(size: 20)
                    .position(coin.position)
            }
            .ignoresSafeArea()
        }
        .onChange(of: isPlaying) { _, newValue in
            if newValue {
                startCoinAnimation()
            } else {
                intervalBetweenCoins = 0
                removeCoins()
                appStorageManager.money += collectedCoins
                GameCenterManager.shared.updateData()
            }
        }
    }
    
    // Start coin falling animation
    private func startCoinAnimation(){
        guard isPlaying else { return }
        DispatchQueue.main.asyncAfter(deadline: .now()){
            moveCoinsDown()
            addCoins()
            collectCoins()
            startCoinAnimation()
        }
    }

    // Adding new coins on the top
    private func addCoins(){
        if intervalBetweenCoins == 3000 {
            let screenWidth = UIScreen.main.bounds.width
            let newCoin = Coin(
                position: CGPoint(
                    x: CGFloat.random(in: 0...screenWidth),
                    y: 0))
            coins.append(newCoin)
            intervalBetweenCoins = 0
        } else {
            intervalBetweenCoins += 1
        }
    }
    
    // Moving coins to the bottom
    private func moveCoinsDown(){
        let screenHeight = UIScreen.main.bounds.height
        coins = coins.map { coin in
            var newCoin = coin
            newCoin.position.y += 5
            return newCoin
        }.filter {
            $0.position.y <= screenHeight
        }
    }
    
    private func removeCoins(){
        coins.removeAll()
    }
   
    // Check for collision between monsters and the ship
    private func collectCoins(){
        for coin in coins {
            if catchCoin(coin: coin, with: shipPosition) {
                if let coinIndex = coins.firstIndex(where: { $0.id == coin.id }) {
                    coins.remove(at: coinIndex)
                    collectedCoins += 20
                    SoundManager.shared.play(sound: .collectionCoins)
                }
                break
            }
        }
    }
    
    // Coin distance to the ship
    private func catchCoin(coin: Coin, with shipPosition: CGPoint) -> Bool {
        let coinPosition = CGRect(x: coin.position.x, y: coin.position.y - 40, width: 20, height: 20)
        let shipSize = sizeForShip(type: appStorageManager.shipType)
        let shipPosition = CGRect(x: shipPosition.x, y: shipPosition.y, width: shipSize, height: shipSize)
        
        return shipPosition.intersects(coinPosition)
    }
}
