//
//  ViewController.swift
//  weWrk
//
//  Created by luis castillo on 2/17/17.
//  Copyright © 2017 luis castillo. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class ViewController: UIViewController {
    @IBOutlet weak var emailField: CustomField!
    @IBOutlet weak var passwordField: CustomField!
    
    override func viewDidLoad() { super.viewDidLoad() }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       view.endEditing(true)
    }

    //Connects to Firebase DataBase service 
    func firebaseAuth(_credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: _credential, completion: { (user, error) in 
            if error != nil {
                print("Unable to authenticate")
            } else {
                print("Successfully authenticates")
                self.completeSignIn(id: (user?.uid)!)
            }})}
    
    func completeSignIn(id: String) {
        let keyChainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("\(keyChainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
    @IBAction func signInMethod(_ sender: Any) {
        if let email = emailField.text , 
            let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { ( user,error) in
                if error == nil {
                    print("user authenticated")
                    self.completeSignIn(id: (user?.uid)!)
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {(user,error) in 
                        if error != nil {
                            print("User created")
                        } else { 
                            print("User couldn't be created")
                        }
                    })
                }
            })
        }}
    
    @IBAction func facebookLogin(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("Unable to authenticate with Facebook")
            } else if result?.isCancelled == true {
                print("cancelled facebook authentication")
            } else {
                print("Successfully authenticated with facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(_credential: credential)
            }
        }
    }
    
}

