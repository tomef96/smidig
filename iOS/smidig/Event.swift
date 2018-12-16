//
//  Event.swift
//  smidig
//
//  Created by Tom Fevang on 10/12/2018.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import Foundation
import Firebase

class Event {
    
    let db = Firestore.firestore()
        
    let author: String
    let place: String
    let title: String
    let description: String
    let spots: String
    let date: String
    let eventId: String
    let time: String
    let category: String
    let subcategory: String
    // TODO: let spotsLeft: Int
    //let isJoined: Bool
    //let image: String
    
    enum Category: String {
        case Sport
        case Gaming
        case Fritid
        case Friluft
    }
    
    enum Place: String {
        case Oslo
        case Trondheim
        case Stavanger
        case Bergen
    }

    init(owner: String, place: String, description: String, date: String, spots: String, title: String, eventId: String, category: String, subcategory: String, time: String) {
        self.author = owner
        self.title = title
        self.date = date
        self.spots = spots
        self.description = description
        self.place = place
        self.eventId = eventId
        self.category = category
        self.subcategory = subcategory
        self.time = time
    }
    
    func leave() {
        let docRef = db.collection("users").document((Auth.auth().currentUser?.uid)!).collection("schedule")
        let eventReference = db.document("events/\(eventId)")
        docRef.getDocuments { (documents, err) in
            for document in (documents?.documents)! {
                let result = document.data().first
                if result?.value as! DocumentReference == eventReference {
                    let document = document.documentID
                    docRef.document(document).delete()
                }
            }
        }
    }
    
    func join() {
        let ref = db.collection("users").document((Auth.auth().currentUser?.uid)!)
        let eventReference = db.document("events/\(eventId)")
        
        ref.collection("schedule").addDocument(data: ["event" : eventReference])
    }
}
