//
//  AudioEngine.swift
//  MightyMet
//
//  Created by Justin Bane on 2/12/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import Foundation
import AVFoundation

struct AudioEngine {
    
    var engine: AVAudioEngine!
    var file: AVAudioFile!
    
    init(sound: String) {
        
        self.engine = AVAudioEngine()
        
        let filePath = Bundle.main.path(forResource: sound, ofType: "aiff")
        let url = URL(fileURLWithPath: filePath!)
        do {
            self.file = try AVAudioFile(forReading: url)
        } catch {
            print("Error loading sound file")
        }
        
    }
    
    func playSound(value: Float, rateOrPitch: String){
        
        let audioPlayerNode = AVAudioPlayerNode()
        
        audioPlayerNode.stop()
        engine.stop()
        engine.reset()
        
        engine.attach(audioPlayerNode)
        
        let changeAudioUnitTime = AVAudioUnitTimePitch()
        
        if (rateOrPitch == "rate") {
            changeAudioUnitTime.rate = value
        } else {
            changeAudioUnitTime.pitch = value
        }
        
        engine.attach(changeAudioUnitTime)
        engine.connect(audioPlayerNode, to: changeAudioUnitTime, format: nil)
        engine.connect(changeAudioUnitTime, to: engine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(file, at: nil, completionHandler: nil)
        do {
            try engine.start()
        } catch {
            print("Audio Engine start failure")
        }
        
        audioPlayerNode.play()
    }
    
}
