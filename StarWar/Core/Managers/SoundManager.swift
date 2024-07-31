//
//  SoundManager.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 16.07.24.
//

import AVFoundation

class SoundManager: NSObject {
    static let shared = SoundManager()
    var appStorageManager = AppStorageManager.shared
    var musicPlayer: AVAudioPlayer?
    var sfxPlayer: AVAudioPlayer?
    
    enum SoundNames: String {
        case soundtrack = "soundtrack"
        case gameBgSound = "game bg sound"
        case pause = "pause"
        case buttonClick = "buttonClick"
        case explosion = "explosion"
        case collectionCoins = "collecting coins"
        case healthRestore = "healthRestore"
        case buy = "buy"
        case error = "error"
    }
    
    func play(sound: SoundNames, withExtension Extension: String = "mp3", numberOfLoops: Int = 0, volume: Float = 1) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: Extension) else {
            print("Audio file not found")
            return
        }
        
        do {
            switch sound {
            case .soundtrack, .gameBgSound:
                guard appStorageManager.isMusicEnabled else { return }
                musicPlayer = try AVAudioPlayer(contentsOf: url)
                musicPlayer?.numberOfLoops = numberOfLoops
                musicPlayer?.volume = volume
                musicPlayer?.play()
                
            default:
                guard appStorageManager.isSFXEnabled else { return }
                sfxPlayer = try AVAudioPlayer(contentsOf: url)
                sfxPlayer?.numberOfLoops = numberOfLoops
                sfxPlayer?.volume = volume
                sfxPlayer?.play()
            }
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
