//
//  RegisterViewController.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 12/6/18.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener {
            (auth, user) in
            if user == nil {
                print("User is logged in")
            } else {
                print("User is not logged in")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    

    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    
    @IBAction func onClick(_ sender: UIButton) {
        if (self.emailTextView.text != nil && self.passwordTextView.text != nil) {
            registerUser(email: (self.emailTextView?.text)!, password: (self.passwordTextView?.text)!)
        }
    }
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            guard (authResult?.user) != nil else { return }
            self.performSegue(withIdentifier: "registrationComplete", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "userIsLoggedIn") {
            if let profileViewController = segue.destination as? ProfileViewController {
                profileViewController.user = self.user
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
