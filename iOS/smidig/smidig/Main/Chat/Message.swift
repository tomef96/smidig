//
//  Message.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 5/14/19.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import Foundation
import Firebase
import MessageKit

struct Message {
    
    let message: String
    let author: String
    let date: Date
    var isOwner: Bool = false
    
    init(message: String, author: String, date: Date) {
        self.message = message
        self.author = author
        self.date = date
    }
    
}
