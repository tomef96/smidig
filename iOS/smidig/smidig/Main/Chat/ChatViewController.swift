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
    }
    
    override func viewWillAppear(_ animated: Bool) {

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
                date: Timestamp())
            
            self.chat.sendMessage(message: message)
            
            print(chat.messages.count)

        }
    }
}
