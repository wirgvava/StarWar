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
}
