//
//  AuthenticatedViewController.swift
//  MightyMet
//
//  Created by Justin Bane on 4/24/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit

class AuthenticatedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(vc, animated: true, completion: nil)
    }

}
