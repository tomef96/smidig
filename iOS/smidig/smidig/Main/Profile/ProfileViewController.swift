//
//  ProfileViewController.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 12/7/18.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    var user: User?
    var handle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "userIsNotLoggedIn") {
            if let loginViewController = segue.destination as? LoginViewController {
                loginViewController.user = Auth.auth().currentUser
            }
        }
    }
    
    @IBAction func signoutButtonClick(_ sender: Any) {
        logoutUser()
    }
    
    func logoutUser() {
        print("Firebase logout: ", Auth.auth().currentUser!)
        print("Firebase logout: ", "Signing out user now")
        if Auth.auth().currentUser != nil {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
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
    @IBAction func changeName(_ sender: UIButton) {
        let appUser = AppUser()
        appUser.changeUsername(to: "Jan")
        appUser.changeDescription(to: "Æ e kul")
    }
    
}
