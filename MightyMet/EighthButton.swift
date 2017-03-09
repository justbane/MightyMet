//
//  EighthButton.swift
//  MightyMet
//
//  Created by Justin Bane on 3/6/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit

class EighthButton: UIButton {

    var is8th: Bool = false
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        MightyMetUI.draw_8thButton(frame: rect, is8th: is8th)
        
    }
    
    func setState() {
        if is8th {
            is8th = false
        } else {
            is8th = true
        }
        setNeedsDisplay()
    }
    
    func setStateFromNotification(_ value: Double) {
        switch value {
        case 2.0:
            is8th = true
            break;
        default:
            is8th = false
        }
        setNeedsDisplay()
    }
 

}
