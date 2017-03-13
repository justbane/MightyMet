//
//  ViewController.swift
//  MightyMet
//
//  Created by Justin Bane on 1/18/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    var metronome: Metronome!

    @IBOutlet weak var BPMSelector: BPMSelectorView!
    @IBOutlet weak var HertzSelector: HertzSelectorView!
    @IBOutlet weak var playButton: PlayButton!
    @IBOutlet weak var playListButton: PlaylistButton!
    @IBOutlet weak var tempoLight: TempoLight!
    @IBOutlet weak var quarterButton: QuarterButton!
    @IBOutlet weak var eigthButton: EighthButton!
    @IBOutlet weak var tripletButton: TripletButton!
    @IBOutlet weak var sixteenthButton: SixteenthButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        Set background
//        let background = Gradients(colorString: "blue").getGradient()
//        background.frame = self.view.bounds
//        self.view.layer.insertSublayer(background, at: 0)
        
        // Initial metronome settings
        BPMSelector.setBpmAngle(88.0)
        BPMSelector.setBpmText(88.0)
        HertzSelector.setHertzAngle(135.0)
        HertzSelector.setHertzText(135.0)
        
        // Setup the gesture for the bmp selector
        let bpmRecognizer = XMCircleGestureRecognizer(midPoint: BPMSelector.center, innerRadius:100, outerRadius:140, target: self, action: #selector(rotateBPMGesture(recognizer:)))
        // Attach gesture to view
        self.view.addGestureRecognizer(bpmRecognizer)
        
        let hertzRecognizer = XMCircleGestureRecognizer(midPoint: HertzSelector.center, innerRadius:55, outerRadius:95, target: self, action: #selector(rotateHertzGesture(recognizer:)))
        // Attach gesture to view
        self.view.addGestureRecognizer(hertzRecognizer)
        
        // Play button observer
        NotificationCenter.default.addObserver(self, selector: #selector(setPlayButtonState), name: NSNotification.Name(rawValue: "metStateChange"), object: nil)
        
        // Tempo light observer
        NotificationCenter.default.addObserver(self, selector: #selector(flashTempo), name: NSNotification.Name(rawValue: "tempoFlash"), object: nil)
        
        // Set button state on divisor change
        NotificationCenter.default.addObserver(self, selector: #selector(setDivButtonState), name: NSNotification.Name(rawValue: "metDivisorChange"), object: nil)
        
        // Set timer validity on app inactive
        NotificationCenter.default.addObserver(self, selector: #selector(startStopMetronome), name: NSNotification.Name(rawValue: "appInactive"), object: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Setup the met object
        metronome = Metronome()
        metronome.setDivisor(1.0)
        metronome.start { (running) in
            if running {
                self.playButton.setRunState(running: running)
            }
        }
        
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
            metronome.setSound(Double(angle))
        }
    }

    @IBAction func pressPlay(_ sender: PlayButton) {
        if metronome.isRunning {
            metronome.stop(completion: { (running) in
                if !running {
                    self.playButton.setRunState(running: running)
                }
            })
            
        } else {
            metronome.start(completion: { (running) in
                if running {
                    self.playButton.setRunState(running: running)
                }
            })
            
        }
    }
    
    func startStopMetronome(_ state: Notification) {
        let data = state.userInfo! as! [String:Bool]
        if data["pauseTimer"]! {
            metronome.stop(completion: { (running) in
                if !running {
                    self.playButton.setRunState(running: running)
                }
            })
        }
    }
    
    func setPlayButtonState(_ state: Notification) {
        let data = state.userInfo! as! [String:Any]
        self.playButton.setRunState(running: (data["isRunning"] != nil))
    }
    
    func flashTempo() {
        self.tempoLight.flash()
    }
    
    @IBAction func pressPlayList(_ sender: PlaylistButton) {
        // Add Firebase stuff here
    }
    
    @IBAction func pressQuarterButton(_ sender: Any) {
        metronome.setDivisor(1.0)
    }
    
    @IBAction func pressEigthButton(_ sender: Any) {
        metronome.setDivisor(2.0)
    }
    
    @IBAction func pressTripletButton(_ sender: Any) {
        metronome.setDivisor(3.0)
    }
    
    @IBAction func pressSixteenthButton(_ sender: Any) {
        metronome.setDivisor(4.0)
    }
    
    func setDivButtonState(_ state: Notification) {
        
        let data = state.userInfo! as! [String:Double]
        
        quarterButton.setStateFromNotification(data["divisorValue"]!)
        eigthButton.setStateFromNotification(data["divisorValue"]!)
        tripletButton.setStateFromNotification(data["divisorValue"]!)
        sixteenthButton.setStateFromNotification(data["divisorValue"]!)
    }

}

