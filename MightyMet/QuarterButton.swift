//
//  QuarterButton.swift
//  MightyMet
//
//  Created by Justin Bane on 3/5/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit

class QuarterButton: UIButton {
    
    var isQuarter: Bool = false
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        MightyMetUI.drawQuarterButton(frame: rect, isQuarter: isQuarter)
        
    }
    
    func setState() {
        if isQuarter {
            isQuarter = false
        } else {
            isQuarter = true
        }
        setNeedsDisplay()
    }
    
    func setStateFromNotification(_ value: Double) {
        switch value {
        case 1.0:
            isQuarter = true
            break;
        default:
            isQuarter = false
        }
        setNeedsDisplay()
    }
    

}
