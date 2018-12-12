//
//  AppUser.swift
//  smidig
//
//  Created by Tom Fevang on 10/12/2018.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class AppUser {
    
    let db: Firestore
    let doc: DocumentReference
    
    init() {
        db = Firestore.firestore()
        doc = db.collection("users").document(Auth.auth().currentUser?.uid ?? "FcfMsztg71QXT2hHq4ST1cJvowD2")
    }
        
    var username: String = ""
    var description = ""
    
    func changeUsername(to username: String) {
        self.username = username
        doc.setData(["username": username], mergeFields: ["username"])
    }
    
    func changeDescription(to description: String) {
        self.description = description
        doc.setData(["description": description], mergeFields: ["description"])
    }
    
    func getUsername(){
            doc.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    self.username = document["username"] as! String
                } else {
                    print("Document does not exist")
                }
            }
        }
}
