//
//  MonsterView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 09.07.24.
//

import SwiftUI

@ViewBuilder
func monsterView(for type: Int) -> some View {
    switch type {
    case 1:     Monster_1()
    case 2:     Monster_2()
    case 3:     Monster_3()
    case 4:     Monster_4()
    default:    Monster_1()
    }
}
