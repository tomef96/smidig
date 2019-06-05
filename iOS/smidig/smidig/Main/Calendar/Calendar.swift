//
//  Calendar.swift
//  smidig
//
//  Created by Tom Fevang on 13/12/2018.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import Foundation
import Firebase

class Calendar: EventTableModel {
    
    override func fetchEvents(completion: @escaping () -> Void) {
        events.removeAll()
        let docRef = db.collection("users")
            .document((Auth.auth()
                .currentUser?.uid)!)
            .collection("schedule")
        docRef.getDocuments { (documents, err) in
            for document in (documents?.documents)! {
                let event = document.data()["event"] as! DocumentReference
                event.getDocument(completion: { (document, err) in
                    if let document = document, document.exists {
                        self.events.append(self.createEvent(from: document))
                    }
                    self.formatDate()
                    completion()
                })
            }
        }
    }
}
