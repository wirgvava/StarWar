//
//  MenuButtons.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 01.07.24.
//

import SwiftUI
import GoogleMobileAds

struct MenuButtons: View {
    @ObservedObject var rewardAdsManager = RewardAdsManager()
    @State private var timer: Timer?
    @State private var timeRemaining: Int = 7200
    @State private var animateToggle: Bool = true
    
    @Binding var shipIsMovingLeft: Bool
    @Binding var shipIsMovingRight: Bool
    
    @Binding var isMarketShown: Bool
    @Binding var isLeaderboardShown: Bool
    @Binding var isSettingsShown: Bool
    
    var sidePadding: CGFloat
    var gameOver: Bool
    
    var body: some View {
        HStack {
            if !isMarketShown && !isLeaderboardShown && !isSettingsShown {
                VStack(spacing: 25) {
                    healthView(heartSize: 40)
                }
                
                Spacer()
                
                if AppStorageManager.timerIsActive {
                    VStack {
                        Spacer()
                        
                        Button {
                            if rewardAdsManager.rewardLoaded {
                                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                                rewardAdsManager.displayReward(from: windowScene.windows.first!.rootViewController!)
                            }
                        } label: {
                            Text("Watch Ad")
                                .customFont(color: .white, size: 24)
                                .scaleEffect(animateToggle ? 1.5 : 1.0)
                        }
                        .onAppear(){
                            let baseAnimation = Animation.easeInOut(duration: 0.5)
                            let repeated = baseAnimation.repeatForever(autoreverses: true)
                            
                            withAnimation(repeated) {
                                animateToggle.toggle()
                            }
                        }
                        
                        Spacer()
                        
                        Text(timeString(time: timeRemaining))
                            .customFont(color: .white, size: 24)
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
                VStack(spacing: 25) {
                    // Market Button
                    Button(action: {
                        print("Coin tapped!")
                        print("Your Current Balance: ", AppStorageManager.money)
                    }) {
                        Image(.coinFrontView)
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    
                    // Leaderboard Button
                    Button(action: {
                        withAnimation {
                            isLeaderboardShown = true
                            shipIsMovingLeft = true
                        }
                    }) {
                        Image(.rating)
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    
                    // Settings Button
                    Button(action: {
                        print("Settings tapped!")
                    }) {
                        Image(.settings)
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
            } else {
                VStack {
                    Spacer()
                    Spacer()
                    Button(action: {
                        closeAction()
                    }) {
                        Image(.closeButton)
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    Spacer()
                }
            }
        }
        .padding(.init(top: 530,
                       leading: sidePadding,
                       bottom: 0,
                       trailing: sidePadding))
        .onChange(of: gameOver) { _, newValue in
            if newValue {
                AppStorageManager.pointOfHealth -= 1
            }
        }
        .onChange(of: AppStorageManager.pointOfHealth) { _, newValue in
            if newValue == 0 {
                rewardAdsManager.loadReward()
                AppStorageManager.date = .now.addingTimeInterval(7200)
                AppStorageManager.timerIsActive = true
                sendNotification()
                startTimer()
            }
        }
        .onAppear() {
            requestNotificationPermission()
            if AppStorageManager.pointOfHealth == 0 {
                let difference = Int(AppStorageManager.date.timeIntervalSince(Date.now))
                self.timeRemaining = difference
                rewardAdsManager.loadReward()
                startTimer()
            }
        }
    }
    
    // Close Action
    private func closeAction(){
        if isMarketShown {
            withAnimation {
                isMarketShown = false
                // do something here with ship
            }
        } else if isLeaderboardShown {
            withAnimation {
                isLeaderboardShown = false
                shipIsMovingLeft = false
            }
        } else if isSettingsShown {
            withAnimation {
                isSettingsShown = false
                shipIsMovingLeft = false
            }
        }
    }
    
    // Timer
    private func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            guard AppStorageManager.timerIsActive else {
                timer?.invalidate()
                timer = nil
                return
            }
            
            let difference = Int(AppStorageManager.date.timeIntervalSince(Date.now))
            self.timeRemaining = difference
            
            if self.timeRemaining < 0 {
                AppStorageManager.pointOfHealth = 6
                AppStorageManager.timerIsActive = false
            }
        })
    }
    
    // Timer format
    private func timeString(time: Int) -> String {
        let hours = time / 3600
        let minutes = (time % 3600) / 60
        let seconds = time % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

#Preview {
    MenuButtons(shipIsMovingLeft: .constant(false),
                shipIsMovingRight: .constant(false),
                isMarketShown: .constant(false),
                isLeaderboardShown: .constant(false),
                isSettingsShown: .constant(false),
                sidePadding: 20,
                gameOver: true)
}
