//
//  EventTableModel.swift
//  smidig
//
//  Created by Tom Fevang on 31/05/2019.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import Foundation
import Firebase

class EventTableModel {
    
    let db = Firestore.firestore()
    
    var events = [Event]()
    
    func fetchEvents(completion: @escaping () -> Void) {}
    
    func createEvent(from document: DocumentSnapshot) -> Event {
        let owner: String = document["owner"]! as! String
        let place: String = document["place"]! as! String
        let description: String = document["description"]! as! String
        let date: String = document["date"]! as! String
        let spots: String = document["spots"]! as! String
        let title: String = document["title"]! as! String
        let category: String = document["category"]! as! String
        let subcategory: String = document["subcategory"] as! String
        let time: String = document["time"] as! String
        let id: String = document["id"]! as! String
        let participants = document["participants"]! as! [String]
        
        return Event(owner: owner, place: place, description: description, date: date, spots: spots, title: title, eventId: id, category: category, subcategory: subcategory, time: time, participants: participants)
    }
    
}
