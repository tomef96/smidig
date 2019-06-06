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
import SwiftMessages

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var handle: AuthStateDidChangeListenerHandle?
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        passwordTextField.delegate = self
        
        passwordTextField.addShadow()
        emailTextField.addShadow()
        displayNameTextField.addShadow()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
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
        if (!((self.emailTextField.text?.isEmpty)!) && !((self.passwordTextField.text?.isEmpty)!) &&
            !((self.displayNameTextField.text?.isEmpty)!)) {
            registerUser(email: (self.emailTextField?.text)!, password: (self.passwordTextField?.text)!, displayName: (self.displayNameTextField?.text)!)
        } else {
            let view = MessageView.viewFromNib(layout: .cardView)
            view.configureTheme(.error)
            view.button?.isHidden = true
            view.configureContent(title: "Feil!", body: "Du må fylle ut alle feltene!")
            SwiftMessages.show(view: view)
        }
    }
    
    func registerUser(email: String, password: String, displayName: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
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
                    case .emailAlreadyInUse:
                        view.configureTheme(.error)
                        view.button?.isHidden = true
                        view.configureContent(title: "Feil!", body: "Det finnes allerede en bruker med denne emailen!")
                        SwiftMessages.show(view: view)
                        break;
                    case .weakPassword:
                        view.configureTheme(.error)
                        view.button?.isHidden = true
                        view.configureContent(title: "Feil!", body: "Passordet er for svakt. Det må inneholde minst 6 tegn. Vi anbefaler en lang setning som alle passord.")
                        SwiftMessages.show(view: view)
                        break;
                    default:
                        print("Ukjent feilmelding")
                    }
                }
            }
            
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
