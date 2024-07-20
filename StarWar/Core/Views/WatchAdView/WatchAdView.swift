//
//  WatchAdView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 15.07.24.
//

import SwiftUI

struct WatchAdView: View {
    @ObservedObject var appStorageManager = AppStorageManager.shared
    @ObservedObject var rewardAdsManager = RewardAdsManager()
    @Binding var isWatchAdViewPresented: Bool
    var collectedCoins: Int
        
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.white)
                .frame(width: UIScreen.main.bounds.width - 50, height: 200)
            Rectangle()
                .foregroundStyle(.white)
                .frame(width: UIScreen.main.bounds.width - 60, height: 210)
            
            VStack {
                HStack {
                    Text(localized: "double.coin.message.first")
                        .customFont(color: .black, size: 30)
                    Text("\(collectedCoins)")
                        .customFont(color: .black, size: 30)
                    
                    CoinView(size: 30)
                }
                
                Text(localized: "double.coin.message.second")
                    .customFont(color: .black, size: 30)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                
                HStack {
                    Button {
                        SoundManager.shared.play(sound: .buttonClick)
                        isWatchAdViewPresented = false
                    } label: {
                        Rectangle()
                            .foregroundColor(.pink)
                            .frame(width: ((UIScreen.main.bounds.width - 60) / 2) - 10,
                                   height: 60)
                            .overlay {
                                Text(localized: "close")
                                    .customFont(color: .black, size: 20)
                            }
                    }
                    
                    Button {
                        showAd()
                    } label: {
                        Rectangle()
                            .foregroundStyle(.limeBullet)
                            .frame(width: ((UIScreen.main.bounds.width - 60) / 2) - 10,
                                   height: 60)
                            .overlay {
                                Text(localized: "watch.ad")
                                    .customFont(color: .black, size: 20)
                            }
                    }
                }
            }
        }
        .onAppear() {
            rewardAdsManager.loadReward()
        }
    }
    
    private func showAd(){
        if rewardAdsManager.rewardLoaded {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            SoundManager.shared.play(sound: .buttonClick)
            rewardAdsManager.displayReward(from: windowScene.windows.first!.rootViewController!) {
                SoundManager.shared.play(sound: .collectionCoins)
                appStorageManager.money += collectedCoins
                isWatchAdViewPresented = false
            }
        }
    }
}

#Preview {
    WatchAdView(isWatchAdViewPresented: .constant(true),
                collectedCoins: 20)
}
