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
    @Binding var sidePadding: CGFloat
    @Binding var gameOver: Bool
    @State private var timer: Timer?
    @State private var timeRemaining: Int = 7200
    @State private var animateToggle: Bool = true
    
    var body: some View {
        HStack {
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
                            .foregroundColor(.white)
                            .font(.custom("Minecraft", size: 24))
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
                        .foregroundColor(.white)
                        .font(.custom("Minecraft", size: 24))
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            VStack(spacing: 25) {
                Button(action: {
                    print("Coin tapped!")
                }) {
                    Image(.coinFrontView)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                Button(action: {
                    print("Coin tapped!")
                }) {
                    Image(.rating)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                Button(action: {
                    print("Settings tapped!")
                }) {
                    Image(.settings)
                        .resizable()
                        .frame(width: 40, height: 40)
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
    MenuButtons(sidePadding: .constant(20),
                gameOver: .constant(true))
}
