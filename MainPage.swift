//
//  MainPage.swift
//  weWrk
//
//  Created by luis castillo on 2/23/17.
//  Copyright © 2017 luis castillo. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class MainPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //|SignOut of firebase by removinf keyChain
    @IBAction func logOut(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "backToSignIn", sender: nil)
    }
    
}
