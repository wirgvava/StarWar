//
//  SoundManager.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 16.07.24.
//

import AVFoundation

class SoundManager: NSObject {
    
    static let shared = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundNames: String {
        case bgSound = "bg_sound"
        case collectionCoins = "collecting coins"
    }
    
    func play(sound: SoundNames, withExtension Extension: String = "wav", numberOfLoops: Int = 1) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: Extension) else {
            print("Audio file not found")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = numberOfLoops
            player?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        player?.stop()
    }
}
