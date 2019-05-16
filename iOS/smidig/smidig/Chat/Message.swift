//
//  Message.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 5/14/19.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import Foundation
import Firebase

class Message {
    
    let message: String
    let author: String
    let date: Timestamp
    
    init(message: String, author: String, date: Timestamp) {
        self.message = message
        self.author = author
        self.date = Timestamp()
    }
    
}
