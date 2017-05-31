//
//  AddPlaylistViewController.swift
//  MightyMet
//
//  Created by Justin Bane on 5/29/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit
import IBAnimatable
import FirebaseAuth
import FirebaseDatabase

class AddPlaylistViewController: AuthenticatedViewController {
    
    @IBOutlet weak var titleLabel: TitleLabel!
    @IBOutlet weak var closeButton: AnimatableButton!
    
    var mainMetronome: Metronome!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set background
        // view.backgroundColor = MightyMetUI.darkBlue
        let background = Gradients(colorString: "blue").getGradient()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at: 0)
        
        titleLabel.labelText = "Add Settings"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser == nil {
            super.showLogin()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
