//
//  ViewController.swift
//  MightyMet
//
//  Created by Justin Bane on 1/18/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//


import UIKit
import AudioKit

class ViewController: UIViewController {
    
    var metronome: Metronome!

    @IBOutlet weak var BPMSelector: BPMSelectorView!
    @IBOutlet weak var HertzSelector: HertzSelectorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set background
        let background = Gradients(colorString: "fuscia").getGradient()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at: 0)
        
        // Initial metronome settings
        BPMSelector.setBpmAngle(80.0)
        BPMSelector.setBpmText(80.0)
        HertzSelector.setHertzAngle(180.0)
        HertzSelector.setHertzText(180.0)
        
        // Setup the gesture for the bmp selector
        let bpmRecognizer = XMCircleGestureRecognizer(midPoint: BPMSelector.center, innerRadius:100, outerRadius:140, target: self, action: #selector(rotateBPMGesture(recognizer:)))
        // Attach gesture to view
        self.view.addGestureRecognizer(bpmRecognizer)
        
        let hertzRecognizer = XMCircleGestureRecognizer(midPoint: HertzSelector.center, innerRadius:55, outerRadius:95, target: self, action: #selector(rotateHertzGesture(recognizer:)))
        // Attach gesture to view
        self.view.addGestureRecognizer(hertzRecognizer)

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Setup the met object
        metronome = Metronome()
        metronome.generate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rotateBPMGesture(recognizer:XMCircleGestureRecognizer)
    {
        if let angle = recognizer.angle?.degrees {
            // Angle is the absolute angle for the current gesture in radians
            BPMSelector.setBpmAngle(angle)
            BPMSelector.setBpmText(angle)
            metronome.setFrequency(Double(angle))
        }
    }
    
    func rotateHertzGesture(recognizer:XMCircleGestureRecognizer)
    {
        if let angle = recognizer.angle?.degrees {
            // Angle is the absolute angle for the current gesture in radians
            HertzSelector.setHertzAngle(angle)
            HertzSelector.setHertzText(angle)
            metronome.setBeepHerz(Double(angle))
        }
    }


}

