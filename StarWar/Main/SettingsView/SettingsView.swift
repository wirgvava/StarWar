//
//  SettingsView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 20.07.24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var languageManager = LanguageManager.shared
    @ObservedObject var appStorageManager = AppStorageManager.shared
    
    var body: some View {
        ZStack {
            Text(localized: "settings")
                .customFont(color: .white, size: 40)
                .padding(.bottom, 350)
            
            VStack(spacing: 20) {
                // MARK: - Sound
                Text(localized: "sound")
                    .customFont(color: .white, size: 24)
                    .padding(.top, 100)
                
                HStack(spacing: 105) {
                    // Music
                    Button {
                        appStorageManager.isMusicEnabled.toggle()
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 50, height: 50)
                            .overlay {
                                ZStack {
                                    Image(.music)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                    
                                    if !appStorageManager.isMusicEnabled {
                                        Image(.slashLine)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                    }
                                }
                            }
                    }
                    
                    // SFX
                    Button {
                        appStorageManager.isSFXEnabled.toggle()
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 50, height: 50)
                            .overlay {
                                ZStack {
                                    Image(.speaker)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                    
                                    if !appStorageManager.isSFXEnabled {
                                        Image(.slashLine)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                    }
                                }
                            }
                    }
                }
                .padding(.bottom)
                
                // MARK: - Language
                Text(localized: "language")
                    .customFont(color: .white, size: 24)
                
                HStack(spacing: 70) {
                    // English
                    Button {
                        languageManager.currentLanguage = .en
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 80, height: 60)
                            .overlay {
                                ZStack {
                                    if appStorageManager.language == .en {
                                        Rectangle()
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.white)
                                            .frame(width: 80, height: 60)
                                    }
                                    Image(.englishFlag)
                                        .resizable()
                                        .frame(width: 70, height: 50)
                                }
                            }
                    }
                    
                    // Spanish
                    Button {
                        languageManager.currentLanguage = .es
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 80, height: 60)
                            .overlay {
                                ZStack {
                                    if appStorageManager.language == .es {
                                        Rectangle()
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.white)
                                            .frame(width: 80, height: 60)
                                    }
                                    Image(.spanishFlag)
                                        .resizable()
                                        .frame(width: 70, height: 50)
                                }
                            }
                    }
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .languageDidChange)) { _ in
            languageManager.objectWillChange.send()
        }
    }
}

#Preview {
    SettingsView()
}
