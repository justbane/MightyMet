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
    
    var midi: AKMIDI
    var clickSampler: AKMIDISampler
    var mixer: AKMixer
    var sequencer: AKSequencer
    
    init() {
        midi = AKMIDI()
        clickSampler = AKMIDISampler()
        mixer = AKMixer()
        sequencer = AKSequencer()
        
        clickSampler.enableMIDI(midi.client, name: "Click midi in")
        mixer.connect(clickSampler)
        
        let reverb = AKCostelloReverb(mixer)
        let dryWetMixer = AKDryWetMixer(mixer, reverb, balance: 0.2)
        AudioKit.output = dryWetMixer
        AudioKit.start()
    }
    
    func generate() {
        
        // Set the sound for the sequencer
        setSound()
        print(getDivisor())
        // Remove any existing tracks
        sequencer.tracks.removeAll()
         // Generate tracks
        let tracks = getDivisor()
        for i in 0...tracks {
            sequencer.newTrack()
            sequencer.tracks[i].setMIDIOutput(clickSampler.midiIn)
            switch i {
            case 0:
                sequencer.tracks[i].add(
                    noteNumber: 72,
                    velocity: 100,
                    position: AKDuration(beats: (Double(i) / self.divisor)),
                    duration: AKDuration(beats: (1.0 / self.divisor)),
                    channel:1
                )
            default:
                sequencer.tracks[i].add(
                    noteNumber: 60,
                    velocity: 100,
                    position: AKDuration(beats: (Double(i) / self.divisor)),
                    duration: AKDuration(beats: (1.0 / self.divisor)),
                    channel:1
                )
            }
        }
        
        sequencer.setLength(AKDuration(beats: Double(self.signature)))
        sequencer.setTempo(self.frequency)
        sequencer.enableLooping()
        
        sequencer.rewind()
        sequencer.play()
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
    
    func getDivisor() -> Int {
        return Int(self.divisor * 4)
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
    
    func setSound() {
        do {
            try clickSampler.loadWav("clave")
        } catch {
            print("Error loading wav file")
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
            isRunning = false
            sequencer.stop()
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
