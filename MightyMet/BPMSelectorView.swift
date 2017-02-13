//
//  BPMSelectorView.swift
//  MightyMet
//
//  Created by Justin Bane on 1/22/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit

class BPMSelectorView: UIView {
    
    var bpmTextValue: String = "0"
    var bpmAngleValue: CGFloat = 0.0
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        MightyMetUI.drawBPMSelector(frame: rect, bPMAngle: bpmAngleValue, bPMText: bpmTextValue)
    }
    
    // Adjust BPM Value
    func setBpmAngle(_ value: CGFloat) {
        var angleValue = 0.0
        angleValue = 360.0 - Double(value)
        
        if angleValue <= 90.0 {
            angleValue = 90.0
        }
        
        self.bpmAngleValue = CGFloat(angleValue)
        setNeedsDisplay()
    }
    
    func setBpmText(_ value: CGFloat) {
        var textValue: String
        if value >= 270.00 {
            textValue = String(format: "%.0f", round(270.00))
        } else {
            textValue = String(format: "%.0f", round(value))
        }
        
        self.bpmTextValue = textValue
        setNeedsDisplay()
    }

}
