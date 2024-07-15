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
    @State private var messageIsPresented: Bool = false
    @Binding var isPlayable: Bool
    @Binding var shipIsMovingLeft: Bool
    @Binding var shipIsUnlocked: Bool
    
    // Navigation
    @Binding var isMarketPresented: Bool
    @Binding var isLeaderboardPresented: Bool
    @Binding var isSettingsPresented: Bool
    @Binding var isAddHighScorePresented: Bool
    @Binding var isWatchAdViewPresented: Bool
    
    var sidePadding: CGFloat
    var gameOver: Bool
    
    var body: some View {
        HStack {
            if !isMarketPresented && !isLeaderboardPresented && !isSettingsPresented {
                VStack(spacing: 25) {
                    healthView(heartSize: 40)
                }
                
                Spacer()
                
                if AppStorageManager.timerIsActive {
                    VStack {
                        Spacer()
                        
                        Button {
                            showAd()
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
                        guard !isAddHighScorePresented else { return }
                        guard !isWatchAdViewPresented else { return }
                        withAnimation {
                            isMarketPresented = true
                            isPlayable = false
                        }
                    }) {
                        Image(.coinFrontView)
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    
                    // Leaderboard Button
                    Button(action: {
                        guard !isAddHighScorePresented else { return }
                        guard !isWatchAdViewPresented else { return }
                        withAnimation {
                            isLeaderboardPresented = true
                            shipIsMovingLeft = true
                        }
                    }) {
                        Image(.rating)
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    
                    // Settings Button
                    Button(action: {
                        guard !isAddHighScorePresented else { return }
                        guard !isWatchAdViewPresented else { return }
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
                    if messageIsPresented {
                        Text("Choose the ship you own.")
                            .customFont(color: .white, size: 20)
                    }
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
        .onChange(of: messageIsPresented) { _, newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(.smooth(duration: 1.0)) {
                        messageIsPresented = false
                    }
                }
            }
        }
    }
    
    private func showAd(){
        if rewardAdsManager.rewardLoaded {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            rewardAdsManager.displayReward(from: windowScene.windows.first!.rootViewController!) {
                AppStorageManager.pointOfHealth = 6
                AppStorageManager.timerIsActive = false
            }
        }
    }
    
    // Close Action
    private func closeAction(){
        if isMarketPresented {
            withAnimation {
                guard shipIsUnlocked else {
                    messageIsPresented = true
                    return
                }
                isMarketPresented = false
                isPlayable = true
            }
        } else if isLeaderboardPresented {
            withAnimation {
                isLeaderboardPresented = false
                shipIsMovingLeft = false
            }
        } else if isSettingsPresented {
            withAnimation {
                isSettingsPresented = false
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
    MenuButtons(isPlayable: .constant(false),
                shipIsMovingLeft: .constant(false),
                shipIsUnlocked: .constant(false),
                isMarketPresented: .constant(false),
                isLeaderboardPresented: .constant(false),
                isSettingsPresented: .constant(false),
                isAddHighScorePresented: .constant(false),
                isWatchAdViewPresented: .constant(false),
                sidePadding: 20,
                gameOver: true)
}
