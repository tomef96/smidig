//
//  CreateEventCollectionViewCell.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 5/31/19.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit

class CreateEventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ctgLabel: UILabel!
    @IBOutlet weak var ctgImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                self.setCellBackgroundColor(for: self, by: self.ctgLabel.text!, transparency: 1)
            }
            else
            {
                self.setCellBackgroundColor(for: self, by: self.ctgLabel.text!, transparency: 0.5)
            }
        }
    }

}
