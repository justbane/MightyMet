//
//  playListTableViewCell.swift
//  MightyMet
//
//  Created by Justin Bane on 5/26/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {

    @IBOutlet weak var playButton: PlayButton!
    
    var tempo: Int = 0
    var subdivision: String = ""
    var key: String = ""
    var signature: Int = 0
    var note: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
