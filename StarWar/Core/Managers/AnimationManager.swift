//
//  AnimationManager.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 21.06.24.
//

import SwiftUI

class AnimationManager: ObservableObject {
    @Published var currentImageIndex = 0
    var speed = DispatchTime.now()
    var images: [ImageResource] = []
    var animationDuration: Double = 0.08

    init(images: [ImageResource], animationDuration: Double = 0.02) {
        self.images = images
        self.animationDuration = animationDuration
    }
    
    func startAnimation(){
        if currentImageIndex == images.count - 1 {
            self.animateReversed()
        } else {
            self.animateInLine()
        }
    }
    
    private func animateInLine(){
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            if self.currentImageIndex == self.images.count - 1 {
                self.startAnimation()
            } else {
                self.currentImageIndex = self.currentImageIndex + 1
                self.animateInLine()
            }
        }
    }
    
    private func animateReversed(){
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            if self.currentImageIndex == 0 {
                self.startAnimation()
            } else {
                self.currentImageIndex = self.currentImageIndex - 1
                self.animateReversed()
            }
        }
    }
}
