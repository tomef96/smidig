//
//  ShadowTextField.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 5/28/19.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit

class ShadowTextField: UITextField {

    textLayer.shadowColor = [UIColor whiteColor].CGColor;
    textLayer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    textLayer.shadowOpacity = 1.0f;
    textLayer.shadowRadius = 1.0f;

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
