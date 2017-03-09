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
    var lowSound: String = "clave-low"
    var divisor: Double = 1.0
    var isRunning: Bool = true

    
    func generate() {
        
        let clickOne = AudioEngine(sound: sound)
        let clickOneLow = AudioEngine(sound: lowSound)
        
        let clickTwo = AudioEngine(sound: sound)
        let clickThree = AudioEngine(sound: sound)
        let clickFour = AudioEngine(sound: sound)
        
        DispatchQueue(label: "MightyMet", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.global())
            .async {
            
            var whichClick = 1
            var curTime = Date().nanosecondsSince1970
            
            // Timer loop
            while self.isRunning {
                if (Date().nanosecondsSince1970 - curTime >= self.getBpmToNanoseconds()) {
                    
                    // Reset the current time
                    curTime = Date().nanosecondsSince1970
                    
                    // Play the sound
                    switch whichClick {
                        case 2:
                            if self.divisor >= 2.0 {
                                clickTwo.playSound(withFlash: false)
                                if self.divisor > 2.0 {
                                    whichClick = 3
                                } else {
                                    whichClick = 1
                                }
                            } else {
                                clickTwo.playSound(withFlash: true)
                                whichClick = 1
                            }
                        break
                        
                        case 3:
                            if self.divisor >= 3.0 {
                                clickThree.playSound(withFlash: false)
                                if self.divisor > 3.0 {
                                    whichClick = 4
                                } else {
                                    whichClick = 1
                                }
                            } else {
                                clickThree.playSound(withFlash: true)
                                whichClick = 4
                            }
                        break
                        
                        case 4:
                            if self.divisor >= 4.0 {
                                clickFour.playSound(withFlash: false)
                            } else {
                                clickFour.playSound(withFlash: true)
                            }
                            whichClick = 1
                        break
                        
                        default:
                            if self.divisor > 1 {
                                clickOneLow.playSound(withFlash: false)
                            } else {
                                clickOne.playSound(withFlash: true)
                            }
                            whichClick = 2
                    }
                    
                }
            }
            
        }
    }
    
    func getBpmToNanoseconds() -> Double {
        return (((1000 / self.frequency) * 60) * 1000000).rounded(.down) / self.divisor
    }
    
    func setFrequency(_ value: Double) {
        self.frequency = value
    }
    
    func getFrequency() -> Double {
        return self.frequency
    }
    
    func setDivisor(_ value: Double) {
        self.divisor = value
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "metDivisorChange"), object: nil, userInfo: ["divisorValue":value])
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
            self.sound = "sticks-analog"
        }
        if (value > 90) && (value < 180.00) {
            self.sound = "clave"
        }
        
        self.lowSound = "\(self.sound)-low"
        
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
