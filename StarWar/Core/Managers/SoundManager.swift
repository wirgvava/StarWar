//
//  SoundManager.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 16.07.24.
//

import AVFoundation

class SoundManager: NSObject {
    
    static let shared = SoundManager()
    
    var mainPlayer: AVAudioPlayer?
    var additionalPlayer: AVAudioPlayer?
    
    enum SoundNames: String {
        case soundtrack = "soundtrack"
        case gameBgSound = "game bg sound"
        case buttonClick = "buttonClick"
        case explosion = "explosion"
        case collectionCoins = "collecting coins"
        case healthRestore = "healthRestore"
        case buy = "buy"
        case error = "error"
    }
    
    func play(sound: SoundNames, withExtension Extension: String = "mp3", numberOfLoops: Int = 0) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: Extension) else {
            print("Audio file not found")
            return
        }
        
        do {
            switch sound {
            case .soundtrack, .gameBgSound:
                mainPlayer = try AVAudioPlayer(contentsOf: url)
                mainPlayer?.numberOfLoops = numberOfLoops
                mainPlayer?.play()
                
            default:
                additionalPlayer = try AVAudioPlayer(contentsOf: url)
                additionalPlayer?.numberOfLoops = numberOfLoops
                additionalPlayer?.play()
            }
            
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
