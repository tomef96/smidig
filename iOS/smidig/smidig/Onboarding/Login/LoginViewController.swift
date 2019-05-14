//
//  LoginViewController.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 12/6/18.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var handle: AuthStateDidChangeListenerHandle?
    var user: User?

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.underlined()
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        emailTextField.returnKeyType = UIReturnKeyType.next
        
        passwordTextField.underlined()
        passwordTextField.returnKeyType = UIReturnKeyType.go
        passwordTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()
        loginUser(loginButton)
        return true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener {
            (auth, user) in
            if user != nil {
                print("Firebase: ", "User is logged in")
                self.performSegue(withIdentifier: "userIsLoggedIn", sender: self)
            } else {
                print("Firebase: ", "User is not logged in")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //if (segue.identifier == "userIsLoggedIn") {
                if let profileViewController = segue.destination as? ProfileViewController {
                    profileViewController.user = self.user
                }
            //}
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBAction func loginUser(_ sender: UIButton) {
        if (self.emailTextField.text != nil && self.passwordTextField.text != nil) {
            loginUser(email: (self.emailTextField?.text)!, password: (self.passwordTextField?.text)!)
        }
    }
    
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            self.user = user?.user
            print("Firebase: ", user?.user as Any)
            print("Firebase: ", user?.user.email as Any)
            print("Firebase: ", self.user as Any)
            print(error ?? "")
            if user?.user != nil {
                self.performSegue(withIdentifier: "userIsLoggedIn", sender: self)
            }
        }
    }
}
