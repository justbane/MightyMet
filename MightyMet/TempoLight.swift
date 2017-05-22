//
//  TempoLight.swift
//  MightyMet
//
//  Created by Justin Bane on 2/3/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit

class TempoLight: UIView {

    var isFlashing: Bool = false
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        MightyMetUI.drawTempoLight(frame: rect, flash: isFlashing)
    }
    
    func flash() {
        DispatchQueue(label: "MightyMet", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.main).async {
            let timeInterval = TimeInterval(0.05)
            // Turn it on
            Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { (timer) in
                self.isFlashing = true
                self.setNeedsDisplay()
            }
            
            // Turn it off
            Timer.scheduledTimer(withTimeInterval: (timeInterval + 0.10), repeats: false) { (timer) in
                self.flashOff()
            }
        }
    }
    
    func flashOff() {
        isFlashing = false
        DispatchQueue(label: "MightyMet", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.main).async {
            self.setNeedsDisplay()
        }
    }
    

}
