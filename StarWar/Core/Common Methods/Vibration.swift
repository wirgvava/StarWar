//
//  Vibration.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 11.07.24.
//

import UIKit

func vibration() {
    let generator = UIImpactFeedbackGenerator(style: .soft)
    generator.impactOccurred()
}
