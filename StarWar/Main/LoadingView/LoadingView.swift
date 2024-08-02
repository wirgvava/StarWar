//
//  LoadingView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 01.08.24.
//

import SwiftUI

struct LoadingView: View {
    @State private var bgOpacity: Double = 0.0
    @State private var bannerTopPadding: CGFloat = 0
    @State private var loaderWidth: CGFloat = 0
    @State private var isLoadingBegan: Bool = false
    @State private var isLoadingComplete: Bool = false
    @State private var contentViewIsPresented: Bool = false
    var appStorageManager = AppStorageManager.shared
    let group = DispatchGroup()
    
    var body: some View {
        ZStack {
            if contentViewIsPresented {
                ContentView()
                    .transition(.opacity)
            } else {
                ZStack {
                    Color.black.ignoresSafeArea()
                    Color.space.ignoresSafeArea()
                        .opacity(bgOpacity)
                    
                    Image(.starWar)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 20)
                        .padding(.top, bannerTopPadding)
                    
                    if isLoadingBegan {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                            .border(.white, width: 5)
                            .foregroundColor(.clear)
                        
                        Rectangle()
                            .frame(width: loaderWidth, height: 30)
                            .foregroundColor(.white)
                            .padding(.trailing, UIScreen.main.bounds.width - (70 + loaderWidth))
                    }
                }
                .onAppear() {
                    onAppearAnimation()
                    gameCenterAuthenticateAndFetchingData()
                    fetchTopScores()
                }
                .onChange(of: isLoadingComplete) { oldValue, newValue in
                    if newValue {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            contentViewIsPresented = true
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Methods
    private func onAppearAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.smooth(duration: 1)) {
                bannerTopPadding = -300
                isLoadingBegan = true
                loaderWidth = UIScreen.main.bounds.width / 2
                bgOpacity = 0.5
            }
        }
    }
    
    private func fetchTopScores() {
        FirestoreManager.shared.getTopScores() {
            isLoadingComplete = true
            withAnimation(.smooth(duration: 1)) {
                bgOpacity = 1
                loaderWidth = UIScreen.main.bounds.width - 70
            }
        }
    }
    
    // - Game Center
    private func gameCenterAuthenticateAndFetchingData() {
        GameCenterManager.shared.authenticate() { isAuthenticated in
            if isAuthenticated {
                self.fetchData()
            }
        }
    }
    
    private func fetchData() {
        GameCenterManager.shared.fetchSavedData { gameData in
            if let gameData = gameData {
                self.appStorageManager.money = gameData.money
                self.appStorageManager.userHighScore = gameData.userHighScore
                self.appStorageManager.unlockedShips = gameData.unlockedShips
            }
        }
    }
}

#Preview {
    LoadingView()
}
