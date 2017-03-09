//
//  SixteenthButton.swift
//  MightyMet
//
//  Created by Justin Bane on 3/5/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit

class SixteenthButton: UIButton {

    var is16th: Bool = false
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        MightyMetUI.draw_16thButton(frame: rect, is16th: is16th)
        
    }
    
    func setState() {
        if is16th {
            is16th = false
        } else {
            is16th = true
        }
        setNeedsDisplay()
    }
    
    func setStateFromNotification(_ value: Double) {
        switch value {
        case 4.0:
            is16th = true
            break;
        default:
            is16th = false
        }
        setNeedsDisplay()
    }

}
