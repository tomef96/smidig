//
//  Chat.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 5/14/19.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import Foundation
import Firebase

class Chat {
    
    let db = Firestore.firestore()
    
    let chatId: String
    var messages: Array<Message> = []
    var members: [String: String] = [:]
    
    init(chatId: String) {
        self.chatId = chatId
        getMessagesForChatWithId(chatId: chatId)
    }
    
    func sendMessage(message: Message) {
        
        db.collection("chats").document(chatId).collection("messages").document().setData([
            "Author": message.author,
            "message": message.message,
            "timestamp": message.date]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
        }
    }
    
    func getMessagesForChatWithId(chatId: String) {
        db.collection("chats").document(chatId).collection("messages").addSnapshotListener { (QuerySnapshot, Error) in
            QuerySnapshot?.documentChanges.forEach({ (DocumentChange) in
                let text = DocumentChange.document.data()["message"]
                let author = DocumentChange.document.data()["Author"]
                let timestamp: Date = DocumentChange.document.data()["timestamp"] as! Date
                
                self.db.collection("users").document(author as! String).getDocument { (document, error) in
                    var username = "ukjent"
                    
                    if (document != nil) {
                        username = document?.data()?["username"] as? String ?? "Ukjent bruker"
                    }
                    
                    let message = Message.init(message: text as! String, author: username, date: Timestamp.init(date: timestamp))
                    
                    self.messages.append(message)
                }
            })
        }
    }
}
