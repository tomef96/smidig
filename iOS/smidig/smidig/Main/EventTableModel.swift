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
    
    let month: Dictionary<Substring, String> = [
        "01": "Jan",
        "02": "Feb",
        "03": "Mars",
        "04": "April",
        "05": "Mai",
        "06": "Juni",
        "07": "Juli",
        "08": "Aug",
        "09": "Sep",
        "10": "Okt",
        "11": "Nov",
        "12": "Des"
    ]
    
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
        cell.icon.image = .init(imageLiteralResourceName: entry.category)
        cell.icon.tintColor = .white
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
    
    func formatDate(event: Event) {
        /*for event in events {
            print(event.date)
            let splicedDate = event.date.split(separator: "/")
            let day = splicedDate[0]
            let month = splicedDate[1]
            event.date = "\(day). \(self.month[month]!)"
        }*/
        let splicedDate = event.date.split(separator: "/")
        let day = splicedDate[0]
        let month = splicedDate[1]
        event.date = "\(day). \(self.month[month]!)"
    }
}

extension UIView {
    func setCellBackgroundColor(for view: UIView, by category: String) {
        switch category {
        case "Hobby":
            view.backgroundColor = #colorLiteral(red: 1, green: 0.4117647059, blue: 0.7058823529, alpha: 1) // #95D26B
        case "Skole":
            view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1) // #F07F5A
        case "Sport":
            view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1) // #42C1F7
        case "Gaming":
            view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1) // #F7C758
        case "Underholdning":
            view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) // #DA407A
        case "Musikk":
            view.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) // #5D11F7
        case "Friluft":
            view.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.8039215686, blue: 0.4980392157, alpha: 1) // #5ACD7F
        case "Kultur":
            view.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.1019607843, blue: 0.5450980392, alpha: 1)
        case "Film og TV":
            view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.337254902, blue: 0.3215686275, alpha: 1)
        case "Annet":
            view.backgroundColor = #colorLiteral(red: 0, green: 0.6549019608, blue: 0.5058823529, alpha: 1)
        default:
            view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.337254902, blue: 0.3215686275, alpha: 1) // #F25652
        }
    }
}
