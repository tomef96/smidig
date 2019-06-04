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
    
    func populateCell(cell: EventTableViewCell, entry: Event) {
        cell.event = entry
        cell.eventTitleLabel.text = entry.title
        cell.spotsLabel?.text = String((Int(entry.spots)! - entry.participants.count)) + " plasser"
        cell.descriptionLabel?.text = entry.description
        cell.placeLabel.text = entry.place
        cell.eventId = entry.eventId
        cell.subcategoryLabel?.text = entry.subcategory
        cell.categoryLabel?.text = entry.category
        cell.timeLabel.text = entry.time
        cell.dateLabel?.text = entry.date
        cell.setCellBackgroundColor(for: cell.cardView, by: entry.category)
        cell.selectionStyle = .none
    }
}

extension UITableViewCell {
    func setCellBackgroundColor(for view: UIView, by category: String) {
        switch category {
        case "Sport":
            view.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) // #95D26B
        case "Gaming":
            view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1) // #F07F5A
        case "Meet Up":
            view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1) // #42C1F7
        case "Underholdning":
            view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1) // #F7C758
        case "Studering":
            view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) // #DA407A
        case "Uteliv":
            view.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) // #5D11F7
        case "Friluft":
            view.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.8039215686, blue: 0.4980392157, alpha: 1) // #5ACD7F
        default:
            view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.337254902, blue: 0.3215686275, alpha: 1) // #F25652
        }
    }
}