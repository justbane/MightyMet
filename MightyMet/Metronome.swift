//
//  Metronome.swift
//  MightyMet
//
//  Created by Justin Bane on 1/23/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import Foundation

class Metronome {
    
    var frequency: Double = 88.0
    var sound: String = "clave"
    var threshold: Double = 250000.00
    var isRunning: Bool = true
    
    func generate() {
        
        let clickOne = AudioEngine(sound: sound)
        
        let clickTwo = AudioEngine(sound: sound)
        
        let clickThree = AudioEngine(sound: sound)
        
        let clickFour = AudioEngine(sound: sound)
        
        DispatchQueue.global(qos: .background).async {
            
            var whichClick = 1
            var curTime = Date().nanosecondsSince1970
            
            // Timer loop
            while self.isRunning {
                if ((Date().nanosecondsSince1970 - curTime) >= self.getBpmToNanoseconds()) {
                    
                    // Reset the current time
                    curTime = Date().nanosecondsSince1970
                    
                    // Play the sound
                    switch whichClick {
                        case 2:
                            clickTwo.playSound(value: 1.0, rateOrPitch: "pitch")
                            whichClick = 3
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tempoFlash"), object: nil, userInfo: nil)
                        break
                        
                        case 3:
                            clickThree.playSound(value: 1.0, rateOrPitch: "pitch")
                            whichClick = 4
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tempoFlash"), object: nil, userInfo: nil)
                        break
                        
                        case 4:
                            clickFour.playSound(value: 1.0, rateOrPitch: "pitch")
                            whichClick = 1
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tempoFlash"), object: nil, userInfo: nil)
                        break
                        
                        default:
                            clickOne.playSound(value: 1.0, rateOrPitch: "pitch")
                            whichClick = 2
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tempoFlash"), object: nil, userInfo: nil)
                    }
                    
                }
            }
            
        }
    }
    
    func getBpmToNanoseconds() -> Double {
        return (((60000.00 / frequency) * 1000000) - self.threshold).rounded(.towardZero)
    }
    
    func setFrequency(_ value: Double) {
        self.frequency = value
    }
    
    func getFrequency() -> Double {
        return self.frequency
    }
    
    func setSound(_ value: Double) {
        isRunning = false
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "metStateChange"), object: nil, userInfo: ["isRunning":isRunning])
        
        if (value >= 180.00) && (value <= 270.00) {
            self.sound = "beep"
        }
        if (value > 270.00) && (value < 360.00) {
            self.sound = "chirp"
        }
        if (value >= 0.0) && (value <= 90.00) {
            self.sound = "sticks"
        }
        if (value > 90) && (value < 180.00) {
            self.sound = "clave"
        }
        
        generate()
        isRunning = true
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "metStateChange"), object: nil, userInfo: ["isRunning":isRunning])
        
    }
    
    func stop (completion: @escaping (_ running: Bool) -> Void) {
        isRunning = false
        completion(isRunning)
    }
    
    func start (completion: @escaping (_ running: Bool) -> Void) {
        isRunning = true
        generate()
        completion(isRunning)
    }
    
}

extension Date {
        var nanosecondsSince1970:Double {
        return Double(((self.timeIntervalSince1970 * 1000) * 1000000))
    }
}
