//
//  CalendarTableViewCell.swift
//  smidig
//
//  Created by Tom Fevang on 04/06/2019.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit

class CalendarTableViewCell: EventTableViewCell {

    @IBOutlet weak var backgroundCard: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
