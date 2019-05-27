//
//  LoginViewController.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 12/6/18.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftMessages

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var handle: AuthStateDidChangeListenerHandle?
    var user: User?

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
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
        if (!(self.emailTextField.text?.isEmpty)! && !(self.passwordTextField.text?.isEmpty)!) {
            loginUser(email: (self.emailTextField?.text)!, password: (self.passwordTextField?.text)!)
        } else {
            let view = MessageView.viewFromNib(layout: .cardView)
            view.configureTheme(.error)
            view.button?.isHidden = true
            view.configureContent(title: "Feil!", body: "Du må fylle ut alle feltene!")
            SwiftMessages.show(view: view)
        }
    }
    
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            self.user = user?.user
            print(error ?? "")
            if user?.user != nil {
                self.performSegue(withIdentifier: "userIsLoggedIn", sender: self)
            }
            if error != nil {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    let view = MessageView.viewFromNib(layout: .cardView)
                    
                    switch errCode {
                    case .wrongPassword:
                        view.configureTheme(.error)
                        view.button?.isHidden = true
                        view.configureContent(title: "Feil!", body: "Brukernavn eller passord er feil!")
                        SwiftMessages.show(view: view)
                        break;
                    case .userNotFound:
                        view.configureTheme(.error)
                        view.button?.isHidden = true
                        view.configureContent(title: "Feil!", body: "Brukernavn eller passord er feil!")
                        SwiftMessages.show(view: view)
                        break;
                    case .invalidEmail:
                        view.configureTheme(.error)
                        view.button?.isHidden = true
                        view.configureContent(title: "Feil!", body: "Du må skrive en gyldig Email adresse!")
                        SwiftMessages.show(view: view)
                        break;
                    default:
                        print("Unknown error")
                    }
                }
            }
        }
    }
}
