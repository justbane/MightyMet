//
//  HertzSelectorView.swift
//  MightyMet
//
//  Created by Justin Bane on 1/24/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit

class HertzSelectorView: UIView {

    var hertzTextValue: String = "0"
    var hertzAngleValue: CGFloat = 0.0
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        MightyMetUI.drawHertzSelector(frame: rect, pitchAngle: hertzAngleValue, hertzText: hertzTextValue)
    }
    
    // Adjust BPM Value
    func setHertzAngle(_ value: CGFloat) {
        var angleValue = 0.0
        angleValue = 360.0 - Double(value)
        self.hertzAngleValue = CGFloat(angleValue)
        setNeedsDisplay()
    }
    
    func setHertzText(_ value: CGFloat) {
        var calcHertz: Double
        let difference = 640.00 - 180.00
        calcHertz = Double(value) + difference
        
        let textValue = String(format: "%.0f", round(calcHertz))
        self.hertzTextValue = textValue
        setNeedsDisplay()
    }

}
