//
//  SoundManager.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-28.
//

import Foundation
import AVKit

class SoundMangaer {
    static let instance = SoundMangaer()
    
    var player: AVAudioPlayer?
    func playSound(_ sound: URL?) {
        guard let sound = sound else {
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: sound)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

let winSound = Bundle.main.url(forResource: "win", withExtension: ".wav")
let lossSound = Bundle.main.url(forResource: "loss", withExtension: ".mp3")
let clickSound = Bundle.main.url(forResource: "click", withExtension: ".wav")
