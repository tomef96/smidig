//
//  Event.swift
//  smidig
//
//  Created by Tom Fevang on 10/12/2018.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import Foundation

class Event {
        
    let author: String
    let place: String
    let title: String
    let description: String
    let spots: String
    //let image: String
    let date: String
    //let isJoined: Bool
    
    init(owner: String, place: String, description: String, date: String, spots: String, title: String) {
        self.author = owner
        self.title = title
        self.date = date
        self.spots = spots
        self.description = description
        self.place = place
    }
}

class Data {
    
    let events = [
        Event(owner: "Jan-Kristian", place: "Grünerløkka", description: "Bli med på fotball!", date: "13/12/2018", spots: "5", title: "Fotball på løkka 1"),
        Event(owner: "Jan-Kristian", place: "Grünerløkka", description: "Bli med på fotball!", date: "13/12/2018", spots: "5", title: "Fotball på løkka 2"),
        Event(owner: "Jan-Kristian", place: "Grünerløkka", description: "Bli med på fotball!", date: "13/12/2018", spots: "5", title: "Fotball på løkka 3")
    ]
    
}
