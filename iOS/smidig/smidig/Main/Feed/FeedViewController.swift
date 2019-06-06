//
//  FeedViewController.swift
//  smidig
//
//  Created by Tom Fevang on 27/05/2019.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filterButton = UIBarButtonItem(image: .init(imageLiteralResourceName: "baseline_filter_list_black_24dp"), style: .plain, target: self, action: #selector(showFilter))
        filterButton.tintColor = UIColor.black
        
        let searchButton = UIBarButtonItem(image: .init(imageLiteralResourceName: "baseline_search_black_24dp"), style: .plain, target: self, action: #selector(showSearch))
        searchButton.tintColor = UIColor.black
        
        navigationItem.rightBarButtonItems = [filterButton, searchButton]
        
        let menuButton = UIBarButtonItem(image: .init(imageLiteralResourceName: "baseline_person_black_24dp"), style: .plain, target: self, action: #selector(showMenu))
        menuButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc
    func showFilter() {
        performSegue(withIdentifier: "FilterSegue", sender: UIBarButtonItem())
    }
    
    @objc
    func showMenu() {
        performSegue(withIdentifier: "MenuSegue", sender: UIBarButtonItem())
    }
    
    @objc
    func showSearch() {
        performSegue(withIdentifier: "SearchSegue", sender: UIBarButtonItem())
    }
}
