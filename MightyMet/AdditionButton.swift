//
//  AdditionButton.swift
//  MightyMet
//
//  Created by Justin Bane on 4/26/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit

class AdditionButton: UIButton {

    var isTapped: Bool = false
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        MightyMetUI.drawAdditionButton(frame: rect, isTapped: isTapped)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTapped = true
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTapped = false
        setNeedsDisplay()
    }
    

}
