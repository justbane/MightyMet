//
//  LoginViewController.swift
//  MightyMet
//
//  Created by Justin Bane on 4/24/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
import IBAnimatable
import TwitterKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    let fbLoginButton = FBSDKLoginButton()
    var twLoginButton = TWTRLogInButton()
    
    @IBOutlet weak var titleLabel: TitleLabel!
    @IBOutlet weak var closeButton: AnimatableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set background
        // view.backgroundColor = MightyMetUI.darkBlue
        let background = Gradients(colorString: "blue").getGradient()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at: 0)
        
        titleLabel.labelText = "LOGIN"
        
        // Login buttons
        setupFacebookButton()
        setupTwitterButton()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupFacebookButton() {
        // Facebook login button
        
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"];
        
        view.addSubview(fbLoginButton)
        fbLoginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          fbLoginButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
          fbLoginButton.widthAnchor.constraint(equalToConstant: 230),
          fbLoginButton.heightAnchor.constraint(equalToConstant: 32),
          fbLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupTwitterButton() {
        // Twitter login Button
        twLoginButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                print("User \(unwrappedSession.userName) has logged in with Twitter")
                let token = unwrappedSession.authToken
                let secret = unwrappedSession.authTokenSecret
                let credentials = FIRTwitterAuthProvider.credential(withToken: token, secret: secret)
                FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
                    if let err = error {
                        print("Firebase Twitter login failed with error: \(err)")
                        return
                    }
                    print("Succesfully logged in with Firebase.")
                    self.dismiss(animated: true, completion: nil)
                })
            } else {
                print("Login error: %@", error!.localizedDescription)
            }
        }
        
        view.addSubview(twLoginButton)
        twLoginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            twLoginButton.topAnchor.constraint(equalTo: fbLoginButton.bottomAnchor, constant: 30),
            twLoginButton.widthAnchor.constraint(equalToConstant: 230),
            twLoginButton.heightAnchor.constraint(equalToConstant: 32),
            twLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result:
        FBSDKLoginManagerLoginResult!, error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        if result.isCancelled {
            print("Login cancelled")
            return
        }
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            if error != nil {
                print ("Nothing worked")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
