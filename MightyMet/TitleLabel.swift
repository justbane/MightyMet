//
//  TitleLabel.swift
//  MightyMet
//
//  Created by Justin Bane on 4/20/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {

    var labelText: String?
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        MightyMetUI.drawTitleLabel(frame: rect, labelText: labelText!)
    }
    

}
