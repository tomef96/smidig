//
//  EventTableViewCell.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 12/12/18.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    var event: Event? = nil
    var eventId: String!
    
    
    @IBOutlet weak var chatButton: ChatButton!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var spotsLabel: UILabel!
    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var categoryRectangle: UIView!
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
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

    func formatDate(date: String) {
        let splicedDate = date.split(separator: "/")
        let day = splicedDate[0]
        let month = splicedDate[1]
        dateLabel.text = "\(day). \(self.month[month]!)"
    }
}
