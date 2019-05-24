//
//  CalendarFeedViewController.swift
//  smidig
//
//  Created by Tom Fevang on 14/12/2018.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import Foundation
import Firebase

class CalendarFeedViewController: FeedViewController {
    
    
    @IBOutlet weak var labelNoEvents: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func fetchEvents() {
        events.removeAll()
        let docRef = db.collection("users")
            .document((Auth.auth()
            .currentUser?.uid)!)
            .collection("schedule")
        docRef.getDocuments { (documents, err) in
            for document in (documents?.documents)! {
                let event = document.data()["event"] as! DocumentReference
                event.getDocument(completion: { (document, err) in
                    if let document = document, document.exists {
                        self.events.append(self.createEvent(from: document))
                        /*if self.events.count > 0 {
                            self.labelNoEvents.isHidden = true
                        } else {
                            self.labelNoEvents.isHidden = false
                            self.labelNoEvents.text = "Ingen eventer"
                        }*/
                        self.labelNoEvents.isHidden = true
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                })
            }
            print(self.events.count)
            if self.events.count == 0 {
                self.labelNoEvents.isHidden = false
                self.labelNoEvents.text = "Ingen eventer"
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        labelNoEvents.isHidden = false
        labelNoEvents.text = "Laster inn..."
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
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
