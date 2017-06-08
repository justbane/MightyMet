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
    
    // Create player node
    let audioPlayerNode = AVAudioPlayerNode()
    
    init(sound: String) {
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback)
            try session.setActive(true)
        } catch {
            print("Error setting session category and activating session")
        }
        
        self.engine = AVAudioEngine()
        
        let filePath = Bundle.main.path(forResource: sound, ofType: "wav")
        let url = URL(fileURLWithPath: filePath!)
        do {
            self.file = try AVAudioFile(forReading: url)
        } catch {
            print("Error loading sound file")
        }
        
        // Attach player node to engine
        engine.attach(audioPlayerNode)
        
        // Prepare file buffer and format
        let audioFormat = file.processingFormat
        let audioFrameCount = UInt32(file.length)
        let audioFileBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount)
        do {
            try file.read(into: audioFileBuffer, frameCount: audioFrameCount)
        } catch {
            print("Error reading file to buffer")
        }
        
        // Setup and connect mixer to engine (engine needs an oputput)
        let mainMixer = engine.mainMixerNode
        engine.connect(audioPlayerNode, to: mainMixer, format: audioFileBuffer.format)
        engine.prepare()
        
        // Set mixer output volume
        mainMixer.outputVolume = 0.9

    }
    
    func playSound(withFlash: Bool){
        
        // Schedule the file then play it
        DispatchQueue(label: "MightyMet", qos: .userInitiated, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.main)
            .async {
                
                // Stop and reset the player node and engine
                self.audioPlayerNode.stop()
                self.engine.stop()
                
                // Start the engine
                do {
                    try self.engine.start()
                } catch {
                    print("Audio engine start failure")
                }
                
                // Flash tempo light if necessary
                if withFlash {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tempoFlash"), object: nil, userInfo: nil)
                }

                
                self.audioPlayerNode.scheduleFile(self.file, at: nil, completionHandler: nil)
                self.audioPlayerNode.play()
        }
        
    }
    
}
