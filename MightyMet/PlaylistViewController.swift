//
//  PlaylistViewController.swift
//  MightyMet
//
//  Created by Justin Bane on 4/20/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit
import FirebaseAuth
import IBAnimatable

class PlaylistViewController: AuthenticatedViewController {

    @IBOutlet weak var titleLabel: TitleLabel!
    @IBOutlet weak var logInOutButton: AnimatableButton!
    @IBOutlet weak var closeButton: AnimatableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set background
        view.backgroundColor = MightyMetUI.darkBlue
        
        titleLabel.labelText = "PLAYLISTS"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser == nil {
            super.showLogin()
        } else {
            logInOutButton.setTitle("LOGOUT", for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch  let error as NSError {
            print("Logout error: ", error)
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
