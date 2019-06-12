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
    
    let alert = UIAlertController(title: "Slett bruker", message: "Er du sikker på at du vil slette brukeren din?", preferredStyle: .alert)
    
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
    
    @IBAction func deleteUser(_ sender: Any) {
        self.present(self.alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.setTitle(Auth.auth().currentUser?.displayName, for: .normal)
        
        alert.addAction(UIAlertAction(title: "Avbryt", style: .destructive, handler: { (action) in
            self.alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Slett", style: .default, handler: { (action) in
            Auth.auth().currentUser?.delete(completion: nil)
        }))
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
