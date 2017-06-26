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
    var callbackInstrument: AKCallbackInstrument
    
    init() {
        
        do {
            try AKSettings.setSession(category: AKSettings.SessionCategory.playback, with: AVAudioSessionCategoryOptions.mixWithOthers)
        } catch {
            print("Error setting audio session category")
        }
        
        midi = AKMIDI()
        clickSampler = AKMIDISampler()
        mixer = AKMixer()
        sequencer = AKSequencer()
        
        // Setup callback instrument to fire functions on note plays
        callbackInstrument = AKCallbackInstrument() { status, note, velocity in
            switch status {
            case .noteOn:
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tempoFlash"), object: nil, userInfo: nil)
            default: break
            }
        }
        
        clickSampler.enableMIDI(midi.client, name: "Click-midiIn")
        mixer.connect(clickSampler)
        
        let reverb = AKCostelloReverb(mixer)
        let dryWetMixer = AKDryWetMixer(mixer, reverb, balance: 0.2)
        AudioKit.output = dryWetMixer
        AudioKit.start()
    }
    
    func generate() {
        
        // Set the sound for the sequencer
        setSound()
        
        // Remove existing tracks
        clearTracks { (clear) in
            if clear {
                // Generate tracks
                let tracks = self.getDivisorToTracks()
                for i in 0...tracks {
                    self.sequencer.newTrack()
                    self.sequencer.tracks[i].setMIDIOutput(self.clickSampler.midiIn)
                    switch i {
                    case 0:
                        self.sequencer.tracks[i].add(
                            noteNumber: 67,
                            velocity: 100,
                            position: AKDuration(beats: (Double(i) / self.divisor)),
                            duration: AKDuration(beats: 0.5),
                            channel:1
                        )
                        break
                        
                    default:
                        var velocity = 75
                        if i % Int(self.divisor) == 0 {
                            velocity = 100
                        }
                        self.sequencer.tracks[i].add(
                            noteNumber: 60,
                            velocity: MIDIVelocity(velocity),
                            position: AKDuration(beats: (Double(i) / self.divisor)),
                            duration: AKDuration(beats: 0.5),
                            channel:1
                        )
                    }
                }
                
                // Setup flasher tracks
                for i in 0...self.signature {
                    let callbackTrack = self.sequencer.newTrack()
                    callbackTrack?.setMIDIOutput(self.callbackInstrument.midiIn)
                    callbackTrack?.add(
                        noteNumber: 0,
                        velocity: 100,
                        position: AKDuration(beats: Double(i)),
                        duration: AKDuration(beats: 0.5),
                        channel:1
                    )
                }
                
                // Figure out the length of the tracks based on the note
                // and the signature for unique counted time signatures
                // TODO: Make this better :)
                var length: Double
                switch self.note {
                case 8:
                    switch self.signature {
                    case 6, 12:
                        length = self.signature / 3
                    default:
                        length = self.signature / 2
                    }
                default:
                    length = Double(self.signature)
                }
                self.sequencer.setLength(AKDuration(beats: length))
                self.sequencer.setTempo(self.frequency)
                self.sequencer.enableLooping()
                self.sequencer.preroll()
                self.sequencer.play()
            }
        }
    }
    
    func clearTracks(completion: @escaping (_ clear: Bool) -> Void) {
        sequencer.tracks.forEach { (track) in
            track.clear()
        }
        completion(true)
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
            sequencer.rewind()
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
