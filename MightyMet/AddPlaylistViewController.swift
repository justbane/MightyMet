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

class AddPlaylistViewController: AuthenticatedViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleLabel: TitleLabel!
    @IBOutlet weak var closeButton: AnimatableButton!
    @IBOutlet weak var saveButton: AnimatableButton!
    @IBOutlet weak var nameField: AnimatableTextField!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var timeSigLabel: UILabel!
    @IBOutlet weak var subdivLabel: UILabel!
    
    var ref: FIRDatabaseReference?
    var mainMetronome: Metronome!
    var background: CAGradientLayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref = FIRDatabase.database().reference()
        
        // Set background
        self.view.backgroundColor = MightyMetUI.darkBlue
        background = Gradients(colorString: "blue").getGradient()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at: 0)
        
        titleLabel.labelText = "ADD SONG SETTINGS"
        
        nameField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser == nil {
            super.showLogin()
        }
        
        bpmLabel.text = "BPM: \(mainMetronome.getFrequency())"
        timeSigLabel.text = "Time Signature: \(mainMetronome.signature)/\(mainMetronome.note)"
        subdivLabel.text = "Subdivision: \(mainMetronome.getTextFromDivisor())s"
    }
    
    override func viewWillLayoutSubviews() {
        background.frame = self.view.bounds
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func pressSaveButton(_ sender: Any) {
        if let name = nameField.text {
            let data: [String: Any] = [
                "name": name,
                "subdivision": mainMetronome.getTextFromDivisor(),
                "tempo": mainMetronome.getFrequency(),
                "signature": mainMetronome.signature,
                "note": mainMetronome.note
            ]
            ref?.child("Playlists").child((FIRAuth.auth()?.currentUser?.uid)!).childByAutoId().setValue(data, withCompletionBlock: { (error, firebase) in
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                }
            })
            
        } else {
            // Throw error
            return
        }
    }
    
}
