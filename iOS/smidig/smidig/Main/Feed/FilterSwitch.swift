//
//  FilterSwitch.swift
//  smidig
//
//  Created by Tom Fevang on 28/05/2019.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit

class FilterSwitch: UISwitch {
    var category: String?
    
    override func didMoveToSuperview() {
        tintColor = .white
    }
}
