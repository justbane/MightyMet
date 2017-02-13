//
//  SoundPlayer.swift
//  MightyMet
//
//  Created by Justin Bane on 1/27/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//
//

import AVFoundation

struct SoundPlayer {
    
    // Properties
    var audioPlayer = AVAudioPlayer()
    
    mutating func setSoundFile(sound: String) {
        let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: sound, ofType: nil)!)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL as URL)
            }
        } catch let error as NSError {
             print(error)
        }
    }
    
    func playSound() {
        audioPlayer.play()
    }
}
