//
//  SetTimeViewController.swift
//  MightyMet
//
//  Created by Justin Bane on 6/1/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit
import IBAnimatable

class SetTimeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var times: [String] = [
        "2/4",
        "3/4",
        "4/4",
        "5/4",
        "6/4",
        "7/4",
        "9/4",
        "5/8",
        "6/8",
        "7/8",
        "9/8",
        "11/8",
        "12/8"
    ]
    
    var mainMetronomeView: ViewController!
    var background: CAGradientLayer!

    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var containerView: AnimatableView!
    @IBOutlet weak var closeButton: AnimatableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set background
        containerView.startColor = MightyMetUI.midBlue
        containerView.endColor = MightyMetUI.darkBlue
        
        timePicker.dataSource = self
        timePicker.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressCloseButton(_ sender: Any) {
        // set met signature
        let index = timePicker.selectedRow(inComponent: 0)
        mainMetronomeView.metronome.setSignature(signature: times[index])
        mainMetronomeView.metronome.stop { (running) in
            if !running {
                self.mainMetronomeView.metronome.start(completion: { (running) in
                    self.mainMetronomeView.playButton.setRunState(running: running)
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabelView = UILabel()
        let titleData = times[row]
        let attibText = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Avenir", size: 22.0)!,NSForegroundColorAttributeName:UIColor.white])
        pickerLabelView.attributedText = attibText
        pickerLabelView.textAlignment = .center
        return pickerLabelView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }

}
