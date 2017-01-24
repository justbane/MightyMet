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
    
    var isMetOn: Bool = false
    var frequency: Double = 60.0
    var beepHerz: Double = 640.0
    var generator: AKOperationGenerator!
    
    func generate() {
        
        generator = AKOperationGenerator() { parameters in
            
            let met = AKOperation.metronome(frequency: parameters[0] / 60)
            // let count = met.count(maximum: 4, looping: true)
            
            let beep = AKOperation.sineWave(frequency: parameters[1])
            // TODO: Add some more sound options against the sinewave: bitcrush, stereo, etc.
            
            let beeps = beep.triggeredWithEnvelope(
                trigger: met,
                attack: 0.01, hold: 0, release: 0.05)
            
            return beeps
        }
        
        generator.parameters[0] = self.getFrequency()
        generator.parameters[1] = self.getBeepHerz()
        
        AudioKit.output = generator
        AudioKit.start()
        generator.start()
    }
    
    func setFrequency(_ value: Double) {
        self.frequency = value
        generator.parameters[0] = value
    }
    
    func setBeepHerz(_ value: Double) {
        
        var calcHertx: Double
        let difference = 640.00 - 180.00
        calcHertx = value + difference
        
        self.beepHerz = calcHertx
        generator.parameters[1] = calcHertx
    }
    
    func getFrequency() -> Double {
        return self.frequency
    }
    
    func getBeepHerz() -> Double {
        return self.beepHerz
    }
    
    
}
