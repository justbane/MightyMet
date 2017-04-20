//
//  Metronome.swift
//  MightyMet
//
//  Created by Justin Bane on 1/23/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import Foundation

class Metronome {
    
    var timer: Timer! = nil
    var frequency: Double = 88.0
    var divisor: Double = 1.0
    var isRunning: Bool = false
    
    var sound: String = "clave"
    var lowSound: String = "clave-low"
    
    var clickOne = AudioEngine(sound: "clave")
    var clickOneLow = AudioEngine(sound: "clave-low")
    
    var clickTwo = AudioEngine(sound: "clave")
    var clickTwoLow = AudioEngine(sound: "clave-low")
    
    var clickThree = AudioEngine(sound: "clave")
    var clickThreeLow = AudioEngine(sound: "clave-low")
    
    var clickFour = AudioEngine(sound: "clave")
    var clickFourLow = AudioEngine(sound: "clave-low")
    
    
    func generate() {
        
        // Set button state on divisor change
        var whichClick = 1
        
        // Setup the Queue
        DispatchQueue(label: "MightyMet", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.main)
            .async {
                
                // Metronome loop
                self.timer = Timer.scheduledTimer(withTimeInterval: self.getBpm(), repeats: true) { (timer) in
                    
                    // Play the sound
                    switch whichClick {
                    case 2:
                        if self.divisor >= 2.0 {
                            self.clickTwoLow.playSound(withFlash: false)
                            if self.divisor > 2.0 {
                                whichClick = 3
                            } else {
                                whichClick = 1
                            }
                        } else {
                            self.clickTwo.playSound(withFlash: true)
                            whichClick = 1
                        }
                        break
                        
                    case 3:
                        if self.divisor >= 3.0 {
                            self.clickThreeLow.playSound(withFlash: false)
                            if self.divisor > 3.0 {
                                whichClick = 4
                            } else {
                                whichClick = 1
                            }
                        } else {
                            self.clickThree.playSound(withFlash: true)
                            whichClick = 4
                        }
                        break
                        
                    case 4:
                        if self.divisor >= 4.0 {
                            self.clickFourLow.playSound(withFlash: false)
                        } else {
                            self.clickFour.playSound(withFlash: true)
                        }
                        whichClick = 1
                        break
                        
                    default:
                        self.clickOne.playSound(withFlash: true)
                        whichClick = 2
                    }
                }
        }
        
    }
    
    func getBpm() -> Double {
        let numberOfPlaces = 3.0
        let multiplier = pow(10.0, numberOfPlaces)
        let num = (60 / self.frequency) / self.divisor
        let rounded = round(num * multiplier) / multiplier
        return rounded
    }
    
    // MARK: Get/set frequency
    func setFrequency(_ value: Double) {
        self.frequency = value
    }
    
    func getFrequency() -> Double {
        return self.frequency
    }
    
    // MARK: Set divisor
    func setDivisor(_ value: Double) {
        self.divisor = value
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "metDivisorChange"), object: nil, userInfo: ["divisorValue":value])
    }
    
    func setSound(_ value: Double) {
        // TODO: Set sounds
    }
    
    func stop (completion: @escaping (_ running: Bool) -> Void) {
        if isRunning {
            isRunning = false
            timer.invalidate()
        }
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
    
    var millisecondsSince1970:Double {
        return Double(self.timeIntervalSince1970 * 1000)
    }
}
