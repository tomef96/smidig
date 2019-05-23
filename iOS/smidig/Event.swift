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
        
    let owner: String
    let place: String
    let title: String
    let description: String
    let spots: String
    let date: String
    let eventId: String
    let time: String
    let category: String
    let subcategory: String
    var participants: [String]
    
    static let categories: Dictionary<String, Array<String>> = [
        "Gaming": ["CS", "Fortnite", "WoW", "Annet"],
        "Sport": ["Fotball", "Hockey", "Basket", "Annet"],
        "Studering": ["Lesing", "Øving", "Annet"],
        "Uteliv": ["Vors", "Fest", "Annet"],
        "Underholdning": ["Kino", "Bowling", "Biljard", "Annet"],
        "Meet Up": ["Annet"],
        "Annet": ["Annet"]
    ]

    init(owner: String, place: String, description: String, date: String, spots: String, title: String, eventId: String, category: String, subcategory: String, time: String, participants: [String]) {
        self.owner = owner
        self.title = title
        self.date = date
        self.spots = spots
        self.description = description
        self.place = place
        self.eventId = eventId
        self.category = category
        self.subcategory = subcategory
        self.time = time
        self.participants = participants
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
                eventReference.collection("members").document(Auth.auth().currentUser!.uid).delete()
                }
            }
        }
    
        let index = participants.index(of: Auth.auth().currentUser!.uid)
        if index != nil {
            participants.remove(at: index!)
            eventReference.setData(["participants": participants], mergeFields: ["participants"])
        }
    }
    
    func join() {
        let ref = db.collection("users").document((Auth.auth().currentUser?.uid)!)
        let eventReference = db.document("events/\(eventId)")
        
        ref.collection("schedule").addDocument(data: ["event" : eventReference])
    /*eventReference.collection("members").document(Auth.auth().currentUser!.uid).setData(["test": "test"])*/
        
        let userId = Auth.auth().currentUser!.uid
        if !participants.contains(userId) {
            participants.append(userId)
            eventReference.setData(["participants": participants], mergeFields: ["participants"])
        }
        
    }
}
