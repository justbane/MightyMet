//
//  TripletButton.swift
//  MightyMet
//
//  Created by Justin Bane on 3/5/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit

class TripletButton: UIButton {

    var isTriplet: Bool = false
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        MightyMetUI.drawTripletButton(frame: rect, isTriplet: isTriplet)
        
    }
    
    func setState() {
        if isTriplet {
            isTriplet = false
        } else {
            isTriplet = true
        }
        setNeedsDisplay()
    }
    
    func setStateFromNotification(_ value: Double) {
        switch value {
        case 3.0:
            isTriplet = true
            break;
        default:
            isTriplet = false
        }
        setNeedsDisplay()
    }

}
