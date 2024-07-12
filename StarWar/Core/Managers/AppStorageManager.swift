//
//  AppStorageManager.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 08.07.24.
//

import SwiftUI

class AppStorageManager {
    @AppStorage("pointOfHealth") static var pointOfHealth: Int = 6
    @AppStorage.Converter("date") static var date: Date = .now
    @AppStorage("timerIsActive") static var timerIsActive = false
    @AppStorage("userHighScore") static var userHighScore: Int = 0
    @AppStorage("money") static var money: Int = 0
    @AppStorage("unlockedShips") static var unlockedShipsJSON: String = "[1]"
    
    static var unlockedShips: [Int] {
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
