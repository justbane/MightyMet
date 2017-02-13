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
        isFlashing = true
        DispatchQueue.main.async {
            self.setNeedsDisplay()
            let timeInterval = TimeInterval(0.1)
            Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { (timer) in
                self.flashOff()
            }
        }
    }
    
    func flashOff() {
        isFlashing = false
        DispatchQueue.main.async { 
            self.setNeedsDisplay()
        }
    }
    

}
