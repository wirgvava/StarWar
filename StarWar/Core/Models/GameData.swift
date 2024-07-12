//
//  GameData.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 12.07.24.
//

import Foundation

struct GameData: Codable {
    let userHighScore: Int
    let money: Int
    let unlockedShips: [Int]
}
