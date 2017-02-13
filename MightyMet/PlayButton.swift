//
//  PlayButton.swift
//  MightyMet
//
//  Created by Justin Bane on 1/29/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit

class PlayButton: UIButton {
    
    var isRunning: Bool = false
    var isNotRunning: Bool = true
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        MightyMetUI.drawPlayButton(frame: rect, isRunning: isRunning, isNotRunning: isNotRunning)
    }
    
    func setRunState(running: Bool) {
        if running {
            isRunning = true
            isNotRunning = false
        } else {
            isRunning = false
            isNotRunning = true
        }
        setNeedsDisplay()
    }

}
