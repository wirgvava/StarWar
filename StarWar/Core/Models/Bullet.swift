//
//  Bullet.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 24.06.24.
//

import SwiftUI

struct Bullet: Identifiable {
    let id = UUID()
    var position: CGPoint
    var type: Int
}
