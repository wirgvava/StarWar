//
//  AppStorageManager.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 08.07.24.
//

import SwiftUI

class AppStorageManager: ObservableObject {
    
    static let shared = AppStorageManager()
    
    @AppStorage("shipType") var shipType: Int = 1
    @AppStorage("pointOfHealth") var pointOfHealth: Int = 6
    @AppStorage.Converter("date") var date: Date = .now
    @AppStorage("timerIsActive") var timerIsActive = false
    @AppStorage("userHighScore") var userHighScore: Int = 0
    @AppStorage("money") var money: Int = 0
    @AppStorage("language") var language: Language = .en
    @AppStorage("isSFXEnabled") var isSFXEnabled = true
    @AppStorage("isMusicEnabled") var isMusicEnabled = true {
        didSet {
            if isMusicEnabled {
                SoundManager.shared.play(sound: .soundtrack, numberOfLoops: -1)
            } else {
                SoundManager.shared.musicPlayer?.stop()
            }
        }
    }
    
    @AppStorage("unlockedShips") var unlockedShipsJSON: String = "[1]"
    
    var unlockedShips: [Int] {
        get {
            decodeJSONToArray(unlockedShipsJSON) ?? []
        }
        set {
            if let jsonString = encodeArrayToJSON(newValue) {
                unlockedShipsJSON = jsonString
            }
        }
    }
}
