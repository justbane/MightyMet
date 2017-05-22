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
    @IBOutlet weak var playButton: PlayButton!
    @IBOutlet weak var playListButton: PlaylistButton!
    @IBOutlet weak var tempoLight: TempoLight!
    @IBOutlet weak var quarterButton: QuarterButton!
    @IBOutlet weak var eigthButton: EighthButton!
    @IBOutlet weak var tripletButton: TripletButton!
    @IBOutlet weak var sixteenthButton: SixteenthButton!
    @IBOutlet weak var tapTempoButton: TapTempo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set background
        view.backgroundColor = MightyMetUI.darkBlue
        
        // MARK: Initial metronome settings
        BPMSelector.setBpmAngle(88.0)
        BPMSelector.setBpmText(88.0)
        
        // MARK: Setup the gesture for the bmp selector
        let bpmRecognizer = XMCircleGestureRecognizer(midPoint: BPMSelector.center, innerRadius:100, outerRadius:140, target: self, action: #selector(rotateBPMGesture(recognizer:)))
        // Attach gesture to view
        self.view.addGestureRecognizer(bpmRecognizer)
        
        // MARK: Play button observer
        NotificationCenter.default.addObserver(self, selector: #selector(setPlayButtonState), name: NSNotification.Name(rawValue: "metStateChange"), object: nil)
        
        // MARK: Tempo light observer
        NotificationCenter.default.addObserver(self, selector: #selector(flashTempo), name: NSNotification.Name(rawValue: "tempoFlash"), object: nil)
        
        // MARK: Set button state on divisor change
        NotificationCenter.default.addObserver(self, selector: #selector(setDivButtonState), name: NSNotification.Name(rawValue: "metDivisorChange"), object: nil)
        
        // MARK: Set timer validity on WillResignActive
        // NotificationCenter.default.addObserver(self, selector: #selector(startStopMetronome), name: NSNotification.Name(rawValue: "appInactive"), object: nil)
        
        // MARK: Init metronome
        metronome = Metronome()
        metronome.setDivisor(1.0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Rotate BPM action
    func rotateBPMGesture(recognizer:XMCircleGestureRecognizer)
    {
        // Stop the met while we change tempo
        metronome.stop(completion: { (running) in
            self.playButton.setRunState(running: running)
        })
        // Update the angle
        if let angle = recognizer.angle?.degrees {
            // Angle is the absolute angle for the current gesture in radians
            self.BPMSelector.setBpmAngle(angle)
            self.BPMSelector.setBpmText(angle)
            self.metronome.setFrequency(Double(angle))
        }
        // Reset metronome with new frequency
        if recognizer.state == .ended {
            metronome.start(completion: { (running) in
                self.playButton.setRunState(running: running)
            })
        }
    }

    // MARK: Press play
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
        // TODO: Implement background flash in settings
        // flashBG()
    }
    
    @IBAction func pressPlayList(_ sender: PlaylistButton) {
        // Add Firebase stuff here
    }
    
    @IBAction func pressQuarterButton(_ sender: Any) {
        setDivisor(divisor: 1.0)
    }
    
    @IBAction func pressEigthButton(_ sender: Any) {
        setDivisor(divisor: 2.0)
    }
    
    @IBAction func pressTripletButton(_ sender: Any) {
        setDivisor(divisor: 3.0)
    }
    
    @IBAction func pressSixteenthButton(_ sender: Any) {
        setDivisor(divisor: 4.0)
    }
    
    // MARK: Tap Tempo
    @IBAction func pressTapTempo(_ sender: TapTempo) {
        
        if sender.isTapped {
            sender.secondPress = Date().millisecondsSince1970
            metronome.setFrequency(60000 / (sender.secondPress! - sender.firstPress!))
            metronome.stop(completion: { (running) in
                self.playButton.setRunState(running: running)
                if !running {
                    self.metronome.start(completion: { (running) in
                        self.playButton.setRunState(running: running)
                        self.BPMSelector.setBpmText(CGFloat(self.metronome.getFrequency()))
                        self.BPMSelector.setBpmAngle(CGFloat(self.metronome.getFrequency()))
                    })
                }
            })
            sender.firstPress = 0
            sender.secondPress = 0
        } else {
            sender.firstPress = Date().millisecondsSince1970
        }
        
        sender.setState()
    }
    
    func setDivisor(divisor: Double) {
        metronome.stop { (running) in
            self.playButton.setRunState(running: running)
            if !running {
                self.metronome.setDivisor(divisor)
                self.metronome.start(completion: { (running) in
                    self.playButton.setRunState(running: running)
                })
            }
        }
    }
    
    func setDivButtonState(_ state: Notification) {
        
        let data = state.userInfo! as! [String:Double]
        
        quarterButton.setStateFromNotification(data["divisorValue"]!)
        eigthButton.setStateFromNotification(data["divisorValue"]!)
        tripletButton.setStateFromNotification(data["divisorValue"]!)
        sixteenthButton.setStateFromNotification(data["divisorValue"]!)
    }
    
    func flashBG() {
        DispatchQueue(label: "MightyMet", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.main).async {
            let timeInterval = TimeInterval(0.05)
            // Turn it on
            Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { (timer) in
                self.view.backgroundColor = MightyMetUI.midBlue
            }
            
            // Turn it off
            Timer.scheduledTimer(withTimeInterval: (timeInterval + 0.10), repeats: false) { (timer) in
                self.view.backgroundColor = MightyMetUI.darkBlue
            }
        }
    }

}

