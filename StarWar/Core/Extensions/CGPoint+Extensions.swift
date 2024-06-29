//
//  CGPoint+Extensions.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 27.06.24.
//

import Foundation

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(self.x - point.x, 2) + pow(self.y - point.y, 2))
    }
}
