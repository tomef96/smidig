//
//  ChatViewController.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 5/15/19.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        chat = Chat(chatId: chatId)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    var chat: Chat!
    var chatId: String!

    @IBOutlet weak var messageTextField: UITextField!
    @IBAction func sendMessageButton(_ sender: UIButton) {
        
        let message = messageTextField.text
        let author = Auth.auth().currentUser?.uid
        
        if (!(message?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! && author != nil) {
            let message = Message.init(
                message: message!,
                author: author!,
                date: Date())
            
            self.chat.sendMessage(message: message)
            
            print(chat.messages.count)

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "chatVCtoTW") {
            let displayTW = segue.destination as! MessageTableViewController
            displayTW.chatId = self.chatId
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

}
