//
//  RegisterViewController.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 12/6/18.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var handle: AuthStateDidChangeListenerHandle?
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        passwordTextField.delegate = self
    }
    
    @IBOutlet weak var registerButton: UIButton!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()
        onClick(registerButton)
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener {
            (auth, user) in
            if user != nil {
                print("User is logged in")
            } else {
                print("User is not logged in")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    @IBAction func onClick(_ sender: UIButton) {
        if (self.emailTextField.text != nil && self.passwordTextField.text != nil &&
            self.displayNameTextField.text != nil) {
            registerUser(email: (self.emailTextField?.text)!, password: (self.passwordTextField?.text)!, displayName: (self.displayNameTextField?.text)!)
        }
    }
    
    func registerUser(email: String, password: String, displayName: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard (authResult?.user) != nil else { return }
            Firestore.firestore().collection("users").document((authResult?.user.uid)!).setData(["username" : displayName])
            let changeRequest = authResult?.user.createProfileChangeRequest()
            changeRequest?.displayName = displayName
            changeRequest?.commitChanges(completion: { (err) in
                
            })
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

}
