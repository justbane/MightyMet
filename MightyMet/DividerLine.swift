//
//  DividerLine.swift
//  MightyMet
//
//  Created by Justin Bane on 4/26/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit

class DividerLine: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        MightyMetUI.drawDividerLine(frame: rect)
    }

}
