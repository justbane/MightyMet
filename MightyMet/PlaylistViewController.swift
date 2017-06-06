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
    var mainMetronomeView: ViewController!
    var background: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Setup the FireBase ref
        ref = FIRDatabase.database().reference()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.reloadData()
        
        // Set background
        self.view.backgroundColor = MightyMetUI.darkBlue
        background = Gradients(colorString: "blue").getGradient()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at: 0)
        
        titleLabel.labelText = "PLAYLIST"
        
    }
    
    override func viewWillLayoutSubviews() {
        background.frame = self.view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser == nil {
            super.showLogin()
        } else {
            logInOutButton.setTitle("LOGOUT", for: .normal)
            
            // Get data
            getplaylist()
        }
    }
    
    // MARK: Get data from Firebase
    func getplaylist() {
        data = []
        ref?.child("Playlists").child((FIRAuth.auth()?.currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            
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
    
    // MARK: Remove row from Firebase
    func removePlaylist(key: String) {
        ref?.child("Playlists").child((FIRAuth.auth()?.currentUser?.uid)!).child(key).setValue(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAddPlaylistSegue" {
            let vc = segue.destination as! AddPlaylistViewController
            vc.mainMetronome = mainMetronomeView.metronome
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let cell = tableView.cellForRow(at: indexPath) as! PlaylistTableViewCell
            removePlaylist(key: cell.key);
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedCellIndexPath = indexPath
        let currentCell = tableView.cellForRow(at: selectedCellIndexPath!) as! PlaylistTableViewCell
        
        // Adjust the met
        let divisor = mainMetronomeView.metronome.getDivisorFromText(name: currentCell.subdivision)
        let frequency = Double(currentCell.tempo)
        let signature = currentCell.signature
        let note = currentCell.note
        mainMetronomeView.metronome.setFrequency(frequency)
        mainMetronomeView.metronome.setSignature(signature: "\(signature)/\(note)")
        mainMetronomeView.metronome.setDivisor(divisor.Divisor)
        
        // Set the view controller controls
        mainMetronomeView.BPMSelector.setBpmAngle(CGFloat(frequency))
        mainMetronomeView.BPMSelector.setBpmText(CGFloat(frequency))
        mainMetronomeView.timeSignatureButton.titleLabel?.text = "\(signature)/\(note)"
        
        var isRunning = false
        if mainMetronomeView.metronome.isRunning {
            mainMetronomeView.metronome.stop(completion: { (running) in
                self.mainMetronomeView.playButton.setRunState(running: running)
                isRunning = running
            })
        } else {
            mainMetronomeView.metronome.start(completion: { (running) in
                self.mainMetronomeView.playButton.setRunState(running: running)
                isRunning = running
            })
        }
        
        // Start the updates
        tableView.beginUpdates()
        
        // Turn on the play button
        currentCell.playButton.setRunState(running: isRunning)
        
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
        cell.key = data[indexPath.row].key
        
        (cell.contentView.viewWithTag(102) as! UILabel).text = cellData["name"] as? String
        
        var settings = ""
        
        if let tempo = cellData["tempo"] {
            settings += "\(tempo)bpm in "
        }
        if let signature = cellData["signature"] {
            settings += "\(signature)/"
        }
        if let note = cellData["note"] {
            settings += "\(note)"
        }
        if let subdivision = cellData["subdivision"] {
            settings += " using \(subdivision) notes"
        }
        
        (cell.contentView.viewWithTag(103) as! UILabel).text = settings

        cell.tempo = cellData["tempo"] as! Int
        cell.subdivision = cellData["subdivision"] as! String
        cell.signature = cellData["signature"] as! Int
        cell.note = cellData["note"] as! Int
        
        return cell
    }

}
