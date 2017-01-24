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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initial metronome settings
        BPMSelector.setBpmAngle(80.0)
        BPMSelector.setBpmText(80.0)
        
        // Setup the gesture for the bmp selector
        let bpmRecognizer = XMCircleGestureRecognizer(midPoint: BPMSelector.center, innerRadius:100, outerRadius:140, target: self, action: #selector(rotateGesture(recognizer:)))
        // Attach gesture to view
        self.view.addGestureRecognizer(bpmRecognizer)
        
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
    
    func rotateGesture(recognizer:XMCircleGestureRecognizer)
    {
        if let angle = recognizer.angle?.degrees {
            // Angle is the absolute angle for the current gesture in radians
            BPMSelector.setBpmAngle(angle)
            BPMSelector.setBpmText(angle)
            
            metronome.setFrequency(Double(angle))
        }
    }


}

