//
//  Searcher.swift
//  smidig
//
//  Created by Tom Fevang on 14/05/2019.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import Foundation
import FirebaseFirestore

class Searcher {
    
    var events = [Event]()
    
    init() {
        fetchEvents()
    }

    func search(for keyword: String, in events: [Event]) -> [Event]? {
        if keyword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {return nil}
        var result = [Event]()
        for event in events {
            let t = event.title.lowercased()
            let d = event.description.lowercased()
            let c = event.category.lowercased()
            let s = event.subcategory.lowercased()
            let k = keyword.lowercased()
            if t.contains(k) || d.contains(k) || c.contains(k) || s.contains(k) {
                result.append(event)
            }
        }
        return result
    }
    
    private func fetchEvents() {
        let db = Firestore.firestore()
        db.collection("events").getDocuments { (documents, err) in
            for document in (documents?.documents)! {
            
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
                let participants: [String] = document["participants"]! as! [String]
                
                self.events.append(Event(owner: owner, place: place, description: description, date: date, spots: spots, title: title, eventId: id, category: category, subcategory: subcategory, time: time, participants: participants))
            
            }
        }
    }
    
}
