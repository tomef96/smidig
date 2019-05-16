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
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var spotsLabel: UILabel!
    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    var eventId: String!
    @IBOutlet weak var categoryRectangle: UIView!
    
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var subcategoryLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        /*backgroundCellView?.clipsToBounds = true
        backgroundCellView?.layer.cornerRadius = 64
        backgroundCellView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]*/
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
