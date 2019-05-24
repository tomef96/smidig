//
//  MessageTableViewCell.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 5/20/19.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    var message: Message? = nil
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var messageTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTopConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        messageLabel.sizeToFit()

        // Configure the view for the selected state
    }

}

@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 10.0
    @IBInspectable var bottomInset: CGFloat = 10.0
    @IBInspectable var leftInset: CGFloat = 10.0
    @IBInspectable var rightInset: CGFloat = 10.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
