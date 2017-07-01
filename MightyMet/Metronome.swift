//
//  Metronome.swift
//  MightyMet
//
//  Created by Justin Bane on 1/23/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import Foundation
import AudioKit

class Metronome {
    
    var frequency: Double = 88.0
    var divisor: Double = 1.0
    var signature = 4
    var note = 4
    var isRunning: Bool = false
    var playOne: Bool = true
    
    let met = AKMetronome()
    
    init() {
        
        AKSettings.playbackWhileMuted = true
        
        met.callback = {
            // Flasher
            self.flash(count: self.met.currentBeat)
            self.setTone(count: self.met.currentBeat)
        }
        
        // TODO: Add mixer here later
        
        AudioKit.output = met
        AudioKit.start()
        
    }
    
    func generate() {
        
        met.tempo = frequency * divisor
        
        // Calculate the divisions and the tempo adjustments
        calculateSubdivision()
        
        // Start the met
        met.restart()
        
    }
    
    func calculateSubdivision() {
        
        if (divisor == 2 || divisor == 3) && note == 8 {
            met.subdivision = signature
        } else {
            met.subdivision = signature * Int(divisor)
        }
        
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
    
    func getDivisorToTracks() -> Int {
        switch note {
        case 8:
            return Int(self.signature)
        default:
            return Int(self.divisor * self.signature)
        }
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
    
    func flash(count: Int) {
        if Int(divisor) == 1 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tempoFlash"), object: nil, userInfo: nil)
            return
        }
        
        if count % Int(divisor) == 1 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tempoFlash"), object: nil, userInfo: nil)
            return
        }
    }
    
    func setTone(count: Int) {
        
        if !playOne {
            met.frequency1 = 783.991
        } else {
            met.frequency1 = 1567.98
        }
        
        if (count - 1) > 1 && divisor > 1.0 && count % Int(divisor) == 1 {
            met.frequency2 = 783.991
        } else {
            met.frequency2 = 1046.0
        }
        
    }
    
    func setSignature(signature: String) {
        
        if let index = signature.characters.index(of: "/") {
            self.signature = Int(signature.substring(to: index))!
            self.note = Int(signature.substring(from: index).trimmingCharacters(in: CharacterSet(charactersIn: "/")))!
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resetDivButtons"), object: nil, userInfo: ["signature": signature])
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setTimeSigButtonText"), object: nil, userInfo: ["signature": signature])
        }
        
    }
    
    func stop (completion: @escaping (_ running: Bool) -> Void) {
        if isRunning {
            met.stop()
            met.reset()
            isRunning = false
        }
        completion(isRunning)
    }
    
    func start (completion: @escaping (_ running: Bool) -> Void) {
        generate()
        isRunning = true
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
