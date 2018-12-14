//
//  CalendarViewController.swift
//  smidig
//
//  Created by Tom Fevang on 13/12/2018.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit
import FirebaseFirestore

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let event = Event(owner: "Yo", place: "Bro", description: "Ha", date: "La", spots: "2", title: "Bli med meg til noragutu", eventId: "id", category: "Gaming", subcategory: "CS", time: "10:30")
        events.append(event)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}
