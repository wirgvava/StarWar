//
//  Star.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 29.06.24.
//

import SwiftUI

struct Star: Identifiable {
    let id = UUID()
    var position: CGPoint
    var type: Int
}
