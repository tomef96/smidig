//
//  Feed.swift
//  smidig
//
//  Created by Tom Fevang on 31/05/2019.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import Foundation
import Firebase

class Feed: EventTableModel {
    
    var filteredEvents: [Event] = []
    var preferences: Dictionary<String, Bool> = UserDefaults.standard.dictionary(forKey: "filterPreferences") as? Dictionary<String, Bool> ?? Dictionary<String, Bool>()
    
    override func fetchEvents(completion: @escaping () -> Void) {
        events.removeAll()
        filteredEvents.removeAll()
        
        db.collection("events").getDocuments { (documents, err) in
            for document in (documents?.documents)! {
                let e = self.createEvent(from: document)
                self.events.append(e)
            }
            self.filterEvents(events: self.events)
            completion()
        }
    }
    
    func filterEvents(events: [Event]) {
        for event in events {
            if !event.participants.contains(Auth.auth().currentUser!.uid) {
                if preferences[event.category] != false {
                    self.filteredEvents.append(event)
                }
            }
        }
        filteredEvents.sort { (left, right) -> Bool in
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let leftDate = dateFormatter.date(from: left.date)
            let rightDate = dateFormatter.date(from: right.date)
            return leftDate! > rightDate!
        }
    }
}
