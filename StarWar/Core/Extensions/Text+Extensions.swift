//
//  Text+Extensions.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 11.07.24.
//

import SwiftUI

extension Text {
    
    init(localized key: String, comment: String = "") {
        self.init(NSLocalizedString(key, comment: comment))
    }
    
    func customFont(color: Color, size: CGFloat) -> some View {
        self
            .font(.custom("Minecraft", size: size))
            .foregroundColor(color)
    }
}
