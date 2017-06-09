//
//  LoginViewController.swift
//  MightyMet
//
//  Created by Justin Bane on 4/24/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FBSDKCoreKit
import FBSDKLoginKit
import IBAnimatable
import TwitterKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    let fbLoginButton = FBSDKLoginButton()
    var twLoginButton = TWTRLogInButton()
    var background: CAGradientLayer!
    var ref: FIRDatabaseReference?
    
    @IBOutlet weak var titleLabel: TitleLabel!
    @IBOutlet weak var closeButton: AnimatableButton!
    @IBOutlet weak var anonLoginButton: UIButton!
    @IBOutlet weak var orLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set background
        self.view.backgroundColor = MightyMetUI.darkBlue
        background = Gradients(colorString: "blue").getGradient()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at: 0)
        
        titleLabel.labelText = "LOGIN"
        
        // Login buttons
        setupFacebookButton()
        setupTwitterButton()
        
    }
    
    override func viewWillLayoutSubviews() {
        background.frame = self.view.bounds
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
          fbLoginButton.topAnchor.constraint(equalTo: orLbl.bottomAnchor, constant: 8),
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
                
                // Associate anon user with new account
                if (FIRAuth.auth()?.currentUser != nil) && (FIRAuth.auth()?.currentUser?.isAnonymous)! {
                    FIRAuth.auth()?.currentUser?.link(with: credentials, completion: { (user, error) in
                        print("Anon acct linked to Twitter acct")
                        do {
                            try FIRAuth.auth()?.signOut()
                            // Log user in
                            FIRAuth.auth()?.signIn(with: credentials) { (user, error) in
                                if error != nil {
                                    print ("Twitter login failed")
                                    return
                                }
                                self.dismiss(animated: true, completion: nil)
                            }
                        } catch {
                            print("Anon user logout and Twitter user login failed")
                        }
                    })
                } else {
                    // Log user in
                    FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
                        if let err = error {
                            print("Firebase Twitter login failed with error: \(err)")
                            return
                        }
                        print("Succesfully logged in with Firebase.")
                        self.dismiss(animated: true, completion: nil)
                    })
                }
                
            } else {
                print("Login session error: %@", error!.localizedDescription)
            }
        }
        
        view.addSubview(twLoginButton)
        twLoginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            twLoginButton.topAnchor.constraint(equalTo: fbLoginButton.bottomAnchor, constant: 8),
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
        
        // Associate anon user with new account
        if (FIRAuth.auth()?.currentUser != nil) && (FIRAuth.auth()?.currentUser?.isAnonymous)! {
            FIRAuth.auth()?.currentUser?.link(with: credential, completion: { (user, error) in
                print("Anon acct linked to Facebook acct")
                do {
                    try FIRAuth.auth()?.signOut()
                    // Log user in
                    FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                        if error != nil {
                            print ("FB login failed")
                            return
                        }
                        self.dismiss(animated: true, completion: nil)
                    }
                } catch {
                    print("Anon user logout and FB user login failed")
                }
            })
        } else {
            // Log user in
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                if error != nil {
                    print ("FB login failed")
                    return
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    @IBAction func pressAnonLoginButton(_ sender: Any) {
        
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
            if error != nil {
                print("Error logging in anonymously")
                return
            }
            self.dismiss(animated: true, completion: nil)
        })
        
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
