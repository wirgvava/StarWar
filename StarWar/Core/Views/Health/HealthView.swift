//
//  HealthView.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 08.07.24.
//

import SwiftUI

private func fullHeart(width: CGFloat, height: CGFloat) -> some View {
    Image(.heartFull)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: width, height: height)
}

private func halfHeart(width: CGFloat, height: CGFloat) -> some View {
    Image(.heartHalf)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: width, height: height)
}

private func emptyHeart(width: CGFloat, height: CGFloat) -> some View {
    Image(.heartEmpty)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: width, height: height)
}

@ViewBuilder
func healthView(heartSize: CGFloat) -> some View {
    switch AppStorageManager.shared.pointOfHealth {
    case 0:
        emptyHeart(width: heartSize, height: heartSize)
        emptyHeart(width: heartSize, height: heartSize)
        emptyHeart(width: heartSize, height: heartSize)
    case 1:
        emptyHeart(width: heartSize, height: heartSize)
        emptyHeart(width: heartSize, height: heartSize)
        halfHeart(width: heartSize, height: heartSize)
    case 2:
        emptyHeart(width: heartSize, height: heartSize)
        emptyHeart(width: heartSize, height: heartSize)
        fullHeart(width: heartSize, height: heartSize)
    case 3:
        emptyHeart(width: heartSize, height: heartSize)
        halfHeart(width: heartSize, height: heartSize)
        fullHeart(width: heartSize, height: heartSize)
    case 4:
        emptyHeart(width: heartSize, height: heartSize)
        fullHeart(width: heartSize, height: heartSize)
        fullHeart(width: heartSize, height: heartSize)
    case 5:
        halfHeart(width: heartSize, height: heartSize)
        fullHeart(width: heartSize, height: heartSize)
        fullHeart(width: heartSize, height: heartSize)
    case 6:
        fullHeart(width: heartSize, height: heartSize)
        fullHeart(width: heartSize, height: heartSize)
        fullHeart(width: heartSize, height: heartSize)
    default:
        fullHeart(width: heartSize, height: heartSize)
        fullHeart(width: heartSize, height: heartSize)
        fullHeart(width: heartSize, height: heartSize)
    }
}
