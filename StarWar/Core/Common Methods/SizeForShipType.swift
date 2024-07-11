//
//  SizeForShipType.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 11.07.24.
//

import Foundation

func sizeForShip(type: Int) -> CGFloat {
    switch type {
    case 1:     50
    case 2:     70
    case 3:     80
    case 4:     90
    case 5:     90
    case 6:     90
    default:    50
    }
}
