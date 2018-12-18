//
//  LoginViewController.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 12/6/18.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    var user: User?

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.underlined()
        passwordTextField.underlined()
        
        // Do any additional setup after loading the view.
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
            if (segue.identifier == "userIsLoggedIn") {
                if let profileViewController = segue.destination as? ProfileViewController {
                    profileViewController.user = self.user
                }
            }
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
