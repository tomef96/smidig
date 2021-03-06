//
//  SearchViewController.swift
//  smidig
//
//  Created by Tom Fevang on 14/05/2019.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    let searcher = Searcher()
    var searchResult: [Event]? = nil
    
    @IBOutlet weak var searchPhrase: UISearchBar!
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        doSearch(keyword: searchText)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func doSearch(keyword: String) {
        self.searchResult = searcher.search(for: keyword, in: searcher.events)
        let child = children[0] as? SearchTableViewController
        child?.events = searchResult ?? [Event]()
        DispatchQueue.main.async {
            child?.tableView.reloadData()
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
    

}
