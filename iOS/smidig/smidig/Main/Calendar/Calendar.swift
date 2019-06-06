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
                        let e = self.createEvent(from: document)
                        //self.formatDate(event: e)
                        self.events.append(e)
                        //self.sortEvents()
                        completion()
                    }
                })
            }
        }
    }
    
    func sortEvents() {
        events.sort { (left, right) -> Bool in
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let leftDate = dateFormatter.date(from: left.date)
            let rightDate = dateFormatter.date(from: right.date)
            return leftDate! < rightDate!
        }
    }
    
}
