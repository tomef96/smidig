//
//  ViewController.swift
//  smidig
//
//  Created by Tom Fevang on 05/12/2018.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener {
            (auth, user) in
            if user != nil {
                print("Firebase: ", "User is logged in")
                self.performSegue(withIdentifier: "loggedIn", sender: self)
            } else {
                print("Firebase: ", "User is not logged in")
                self.performSegue(withIdentifier: "notLoggedIn", sender: self)
            }
        }
    }
    
}

