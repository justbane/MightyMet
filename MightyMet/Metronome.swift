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
    var signature = 4
    var note = 4
    var isRunning: Bool = false
    var whichClick = 1
    
    var one = AudioEngine(sound: "clave-high")
    
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
        var count = 1
        
        // Setup the Queue
        DispatchQueue(label: "MightyMet", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.main)
            .async {
                
                // Metronome loop
                self.timer = Timer.scheduledTimer(withTimeInterval: self.getBpm(), repeats: true) { (timer) in
                    
                    // Play proper sound
                    if count % Int(self.divisor) == 1 {
                        if count == 1 {
                            self.playSound(one: true)
                        } else {
                            self.playSound(one: false)
                        }
                    } else {
                        if count == 1 {
                            self.playSound(one: true)
                        } else if self.divisor == 1.0 && count > 1 {
                            self.playSound(one: false)
                        } else {
                            self.playSound(one: false, low: true)
                        }
                        
                    }
                    
                    // Check/reset the count
                    if self.divisor == 2.0 // Working with odd eigths times
                        && self.signature > 4
                        && (self.signature % 2) == 1
                        && self.note == 8 {
                        if count == self.signature {
                            count = 1
                        } else {
                            count += 1
                        }
                    } else if self.divisor == 3.0 // Working with 6/8 or 12/8 time
                        && (self.signature == 6 || self.signature == 12)
                        && self.note == 8 {
                        if count == self.signature {
                            count = 1
                        } else {
                            count += 1
                        }
                    } else { // Default even times and subdivisions
                        if count < (self.signature * Int(self.divisor)) {
                            count += 1
                        } else {
                            count = 1
                        }
                    }
                    
                }
        }
        
    }
    
    func playSound(one: Bool, low: Bool = false) {
        if one {
            self.one.playSound(withFlash: true)
        } else {
            switch whichClick {
            case 1:
                if !low {
                    self.clickOne.playSound(withFlash: true)
                } else {
                    self.clickOneLow.playSound(withFlash: false)
                }
                
            case 2:
                if !low {
                    self.clickTwo.playSound(withFlash: true)
                } else {
                    self.clickTwoLow.playSound(withFlash: false)
                }
                
            case 3:
                if !low {
                    self.clickThree.playSound(withFlash: true)
                } else {
                    self.clickThreeLow.playSound(withFlash: false)
                }
                
            case 4:
                if !low {
                    self.clickFour.playSound(withFlash: true)
                } else {
                    self.clickFourLow.playSound(withFlash: false)
                }
                
            default:
                self.one.playSound(withFlash: true)
            }
            
            if whichClick == 4 {
                whichClick = 1
            } else {
                whichClick += 1
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
        return self.frequency.rounded()
    }
    
    // MARK: Set divisor
    func setDivisor(_ value: Double) {
        self.divisor = value
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "metDivisorChange"), object: nil, userInfo: ["divisorValue":value])
    }
    
    func getDivisorFromText(name: String) -> (Divisor: Double, Name: String) {
        switch name {
            case "quarter":
                return (Subdivisions.quarter.rawValue, name)
            case "eighth":
                return (Subdivisions.eighth.rawValue, name)
            case "triplet":
                return (Subdivisions.triplet.rawValue, name)
            case "sixteenth":
                return (Subdivisions.sixteenth.rawValue, name)
            default:
                return (Subdivisions.quarter.rawValue, name)
        }
    }
    
    func getTextFromDivisor() -> String {
        
        switch divisor {
        case 1.0:
            return "quarter"
        case 2.0:
            return "eighth"
        case 3.0:
            return "triplet"
        case 4.0:
            return "sixteenth"
        default:
            return "quarter"
        }
        
    }
    
    func setSound(_ value: Double) {
        // TODO: Set sounds
    }
    
    func setSignature(signature: String) {
        
        if let index = signature.characters.index(of: "/") {
            self.signature = Int(signature.substring(to: index))!
            self.note = Int(signature.substring(from: index).trimmingCharacters(in: CharacterSet(charactersIn: "/")))!
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resetDivButtons"), object: nil, userInfo: ["signature":signature])
        }
        
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
