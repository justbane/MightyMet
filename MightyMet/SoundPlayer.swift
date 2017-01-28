//
//  SoundPlayer.swift
//  MightyMet
//
//  Created by Justin Bane on 1/27/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

//
//  SoundPlayer.swift
//  MightyMinders
//
//  Created by Justin Bane on 10/30/16.
//  Copyright © 2016 Justin Bane. All rights reserved.
//

import AVFoundation

class SoundPlayer {
    
    // Singleton in order to access the player from 'everywhere'
    static let sharedInstance: SoundPlayer = {
        let instance = SoundPlayer()
        return instance
    }()
    
    // Properties
    var audioPlayer = AVAudioPlayer()
    
    func setSoundFile(sound: String) {
        let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: sound, ofType: nil)!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL as URL)
        } catch {
            print("Audio session error")
        }
    }
    
    func playSound() {
        if (audioPlayer.isPlaying) {
            audioPlayer.stop()
        }
        audioPlayer.play()
    }
}
