//
//  PlaylistButton.swift
//  MightyMet
//
//  Created by Justin Bane on 1/29/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit

class PlaylistButton: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        MightyMetUI.drawPlaylistButton(frame: rect)
    }
    

}
