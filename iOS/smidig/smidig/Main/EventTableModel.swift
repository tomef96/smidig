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
    
    static let month: Dictionary<Substring, String> = [
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
        let time: String = document["time"] as! String
        let id: String = document["id"]! as! String
        let participants = document["participants"]! as! [String]
        
        return Event(owner: owner, place: place, description: description, date: date, spots: spots, title: title, eventId: id, category: category, time: time, participants: participants)
    }
    
    func populateCell(cell: EventTableViewCell, entry: Event) {
        cell.event = entry
        cell.icon.image = .init(imageLiteralResourceName: entry.category)
        cell.icon.tintColor = .white
        cell.eventTitleLabel.text = entry.title
        let spotsFormat = (Int(entry.spots)! - entry.participants.count) == 1 ? " plass" : " plasser"
        cell.spotsLabel?.text = String((Int(entry.spots)! - entry.participants.count)) + spotsFormat
        cell.descriptionLabel?.text = entry.description
        cell.placeLabel.text = entry.place
        cell.eventId = entry.eventId
        cell.categoryLabel?.text = entry.category
        cell.timeLabel.text = entry.time
        cell.dateLabel?.text = EventTableModel.formatDate(date: entry.date)
        cell.setCellBackgroundColor(for: cell.cardView, by: entry.category, transparency: 1)
        cell.selectionStyle = .none
    }
    
    static func formatDate(date: String) -> String {
        let splicedDate = date.split(separator: "/")
        let day = splicedDate[0]
        let month = splicedDate[1]
        return "\(day). \(self.month[month]!)"
    }
}

//extension UIView {
//    func addShadow() {
//        
//        //layer.cornerRadius = 8
//
//        layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
//        layer.borderWidth = 0.25
//        layer.shadowColor = UIColor.black.cgColor //Any dark color
//        layer.shadowRadius = 2.0
//        layer.shadowOpacity = 0.125
//        layer.shadowOffset = CGSize(width: 0, height: 2)
//
//        //clipsToBounds = false
//
//        //let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
//    }
//}



extension UIView {
    func setCellBackgroundColor(for view: UIView, by category: String, transparency transparent: CGFloat = 1) {
        switch category {
        case "Hobby":
            view.backgroundColor = #colorLiteral(red: 1, green: 0.4117647059, blue: 0.7058823529, alpha: 1).withAlphaComponent(transparent) // #95D26B
        case "Skole":
            view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1).withAlphaComponent(transparent) // #F07F5A
        case "Sport":
            view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).withAlphaComponent(transparent) // #42C1F7
        case "Gaming":
            view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).withAlphaComponent(transparent) // #F7C758
        case "Underholdning":
            view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1).withAlphaComponent(transparent) // #DA407A
        case "Musikk":
            view.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).withAlphaComponent(transparent) // #5D11F7
        case "Friluft":
            view.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.8039215686, blue: 0.4980392157, alpha: 1).withAlphaComponent(transparent) // #5ACD7F
        case "Kultur":
            view.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.1019607843, blue: 0.5450980392, alpha: 1).withAlphaComponent(transparent)
        case "Film og TV":
            view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.337254902, blue: 0.3215686275, alpha: 1).withAlphaComponent(transparent)
        case "Annet":
            view.backgroundColor = #colorLiteral(red: 0.3568627451, green: 0.6274509804, blue: 0.6235294118, alpha: 1).withAlphaComponent(transparent)
        default:
            view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.337254902, blue: 0.3215686275, alpha: 1).withAlphaComponent(transparent) // #F25652
        }
    }
}
