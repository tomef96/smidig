//
//  MenuViewController.swift
//  smidig
//
//  Created by Tom Fevang on 03/06/2019.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
    
    @IBOutlet weak var username: UIButton!
    var user: User?
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signOutBtn(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.setTitle(Auth.auth().currentUser?.displayName, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener {
            (auth, user) in
            if Auth.auth().currentUser != nil {
                print("Firebase: ", "User is logged in")
                print("Firebase: ", Auth.auth().currentUser!)
            } else {
                print("Firebase: ", "User is not logged in")
                self.performSegue(withIdentifier: "userIsNotLoggedIn", sender: self)
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
