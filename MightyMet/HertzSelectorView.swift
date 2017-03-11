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
        var textValue: String!
        if (value >= 180.00) && (value <= 270.00) {
            textValue = "Snare"
        }
        if (value > 270.00) && (value < 360.00) {
            textValue = "Cowbell"
        }
        if (value >= 0.0) && (value <= 90.00) {
            textValue = "Sticks"
        }
        if (value > 90) && (value < 180.00) {
            textValue = "Clave"
        }
        
        self.hertzTextValue = textValue
        setNeedsDisplay()
    }

}
