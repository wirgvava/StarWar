//
//  Monster.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 29.06.24.
//

import SwiftUI

struct Monster: Identifiable {
    let id = UUID()
    var position: CGPoint
    var monsterType: Int
}
