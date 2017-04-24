//
//  PlaylistViewController.swift
//  MightyMet
//
//  Created by Justin Bane on 4/20/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {

    @IBOutlet weak var titleLabel: TitleLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.labelText = "PLAYLISTS"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
