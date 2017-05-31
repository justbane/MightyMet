//
//  PlaylistViewController.swift
//  MightyMet
//
//  Created by Justin Bane on 4/20/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import IBAnimatable

class PlaylistViewController: AuthenticatedViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titleLabel: TitleLabel!
    @IBOutlet weak var logInOutButton: AnimatableButton!
    @IBOutlet weak var closeButton: AnimatableButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addPlaylistButton: AdditionButton!
    
    var ref: FIRDatabaseReference?
    var data: [FIRDataSnapshot]! = []
    var selectedCellIndexPath: IndexPath?
    var mainMetronome: Metronome!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Setup the FireBase ref
        ref = FIRDatabase.database().reference()
//        let testData = [
//            "name": "Simply Saved",
//            "tempo": "122",
//            "subdivision": "4"
//        ]
//        ref.child("Playlists").child((FIRAuth.auth()?.currentUser?.uid)!).childByAutoId().setValue(testData)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.reloadData()
        
        // Set background
        // view.backgroundColor = MightyMetUI.darkBlue
        let background = Gradients(colorString: "blue").getGradient()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at: 0)
        
        titleLabel.labelText = "PLAYLIST"
        
        // Get data
        getplaylist()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser == nil {
            super.showLogin()
        } else {
            logInOutButton.setTitle("LOGOUT", for: .normal)
        }
    }
    
    func getplaylist() {
        ref?.child("Playlists").child((FIRAuth.auth()?.currentUser?.uid)!).observe(.value, with: { (snapshot) in
            
            // Get user value
            let enumerator = snapshot.children
            while let child = enumerator.nextObject() as? FIRDataSnapshot {
                self.data.append(child)
            }
            self.tableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAddPlaylistSegue" {
            let vc = segue.destination as! AddPlaylistViewController
            vc.mainMetronome = mainMetronome
        }
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath {
            return // Don't change a thing
        } else {
            selectedCellIndexPath = indexPath
        }
        
        let currentCell = tableView.cellForRow(at: selectedCellIndexPath!) as! PlaylistTableViewCell
        
        // Adjust the met
        let divisor = mainMetronome.getDivisorFromText(name: currentCell.subdivision)
        let frequency = Double(currentCell.tempo)
        mainMetronome.setDivisor(divisor.Divisor)
        mainMetronome.setFrequency(frequency!)
        if mainMetronome.isRunning {
            mainMetronome.stop(completion: { (running) in
                if !running {
                    self.mainMetronome.start(completion: { (running) in
                        // Nothing to do here
                    })
                }
            })
        } else {
            self.mainMetronome.start(completion: { (running) in
                // Nothing to do here
            })
        }
        
        // Start the updates
        tableView.beginUpdates()
        
        // Turn on the play button
        currentCell.playButton.setRunState(running: true)
        
        // End the updates
        tableView.endUpdates()
        
        if selectedCellIndexPath != nil {
            // This ensures, that the cell is fully visible once expanded
            tableView.scrollToRow(at: indexPath, at: .none, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! PlaylistTableViewCell
        
        cell.playButton.setRunState(running: false)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playListCell") as! PlaylistTableViewCell
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let cellData = data[indexPath.row].value as! [String: AnyObject]
        
        (cell.contentView.viewWithTag(102) as! UILabel).text = cellData["name"] as? String
        
        var settings = ""
        
        if let tempo = cellData["tempo"] {
            settings += "\(tempo)bpm"
        }
        if let subdivision = cellData["subdivision"] {
            settings += " in \(subdivision) notes"
        }
        
        (cell.contentView.viewWithTag(103) as! UILabel).text = settings
        
        cell.tempo = cellData["tempo"] as! String
        cell.subdivision = cellData["subdivision"] as! String
        
        return cell
    }

}
