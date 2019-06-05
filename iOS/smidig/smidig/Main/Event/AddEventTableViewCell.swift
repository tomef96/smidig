//
//  AddEventTableViewCell.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 5/28/19.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit

class AddEventTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }

}
