//
//  StarView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 30.06.24.
//

import SwiftUI

@ViewBuilder
func starView(for type: Int) -> some View {
    switch type {
    case 1:
        star(opacity: 0.8, size: 34)
    case 2:
        star(opacity: 0.8, size: 30)
    case 3:
        star(opacity: 0.8, size: 24)
    case 4:
        star(opacity: 0.8, size: 20)
    case 5:
        star(opacity: 0.8, size: 14)
    case 6:
        star(opacity: 0.8, size: 10)
    case 7:
        star(opacity: 0.8, size: 8)
    case 8:
        star(opacity: 0.8, size: 6)
    case 9:
        star(opacity: 0.6, size: 34)
    case 10:
        star(opacity: 0.6, size: 30)
    case 11:
        star(opacity: 0.6, size: 24)
    case 12:
        star(opacity: 0.6, size: 20)
    case 13:
        star(opacity: 0.6, size: 14)
    case 14:
        star(opacity: 0.6, size: 10)
    case 15:
        star(opacity: 0.6, size: 8)
    case 16:
        star(opacity: 0.6, size: 6)
    case 17:
        star(opacity: 0.4, size: 34)
    case 18:
        star(opacity: 0.4, size: 30)
    case 19:
        star(opacity: 0.4, size: 24)
    case 20:
        star(opacity: 0.4, size: 20)
    case 21:
        star(opacity: 0.4, size: 14)
    case 22:
        star(opacity: 0.4, size: 10)
    case 23:
        star(opacity: 0.4, size: 8)
    case 24:
        star(opacity: 0.4, size: 6)
    case 25:
        star(opacity: 0.2, size: 34)
    case 26:
        star(opacity: 0.2, size: 30)
    case 27:
        star(opacity: 0.2, size: 24)
    case 28:
        star(opacity: 0.2, size: 20)
    case 29:
        star(opacity: 0.2, size: 14)
    case 30:
        star(opacity: 0.2, size: 10)
    case 31:
        star(opacity: 0.2, size: 8)
    case 32:
        star(opacity: 0.2, size: 6)
        
    default:
        star(opacity: 0.8, size: 34)
    }
}

private func star(opacity: Double, size: CGFloat) -> some View {
    Text(".")
        .font(.custom("Minecraft", size: size))
        .foregroundColor(.white)
        .opacity(opacity)
}
