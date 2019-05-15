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

    func search(keyword: String, events: [Event]) -> [Event] {
        var result = [Event]()
        for event in events {
            let t = event.title.lowercased()
            let d = event.description.lowercased()
            let s = event.subcategory.lowercased()
            let k = keyword.lowercased()
            if t.contains(k) || d.contains(k) || s.contains(k) {
                result.append(event)
            }
        }
        return result
    }
    
    /*private func fetchResult(searchParam: String) -> [Event] {
        let db = Firestore.firestore()
        let ref = db.collection("events")
    }*/
    
}
