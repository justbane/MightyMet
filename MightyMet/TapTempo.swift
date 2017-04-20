//
//  TapTempo.swift
//  MightyMet
//
//  Created by Justin Bane on 4/16/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit

class TapTempo: UIButton {

    var isTapped:Bool = false
    var firstPress: TimeInterval?
    var secondPress: TimeInterval?
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        MightyMetUI.drawTapTempo(frame: rect, isTapped: isTapped)
    }
    
    func setState() {
        if isTapped {
            isTapped = false
        } else {
            isTapped = true
        }
        setNeedsDisplay()
    }
    
}
