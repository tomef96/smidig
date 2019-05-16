//
//  SearchTableViewCell.swift
//  smidig
//
//  Created by Tom Fevang on 15/05/2019.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    var event: Event? = nil
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPlace: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
