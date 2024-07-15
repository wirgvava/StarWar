//
//  WatchAdView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 15.07.24.
//

import SwiftUI

struct WatchAdView: View {
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
                    Text("You earned \(collectedCoins)")
                        .customFont(color: .black, size: 30)
                    
                    CoinView(size: 30)
                }
                
                Text("Watch ad to double it")
                    .customFont(color: .black, size: 30)
                    .padding(.bottom, 20)
                
                HStack {
                    Button {
                        isWatchAdViewPresented = false
                    } label: {
                        Rectangle()
                            .foregroundColor(.pink)
                            .frame(width: ((UIScreen.main.bounds.width - 60) / 2) - 10,
                                   height: 60)
                            .overlay {
                                Text("Close")
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
                                Text("Watch Ad")
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
            rewardAdsManager.displayReward(from: windowScene.windows.first!.rootViewController!) {
                AppStorageManager.money += collectedCoins
                isWatchAdViewPresented = false
            }
        }
    }
}

#Preview {
    WatchAdView(isWatchAdViewPresented: .constant(true),
                collectedCoins: 20)
}
