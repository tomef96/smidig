//
//  FeedTableViewController.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 12/12/18.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {

    let feed = Feed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
//        for event in feed.filteredEvents {
//            feed.formatDate(event: event)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        feed.preferences = UserDefaults.standard.dictionary(forKey: "filterPreferences") as? Dictionary<String, Bool> ?? Dictionary<String, Bool>()
        feed.fetchEvents {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        feed.events.removeAll()
        feed.filteredEvents.removeAll()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.filteredEvents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! FeedTableViewCell
        if feed.filteredEvents.isEmpty {
            return cell
        }
        let entry = feed.filteredEvents[indexPath.row]
        feed.populateCell(cell: cell, entry: entry)
        cell.cardView.addShadow()
        cell.calendarIcon.image = cell.calendarIcon.image?.withRenderingMode(.alwaysTemplate)
        cell.clockIcon.image = cell.clockIcon.image?.withRenderingMode(.alwaysTemplate)
        cell.calendarIcon.tintColor = .white
        cell.clockIcon.tintColor = .white
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! EventTableViewCell
        let destination = segue.destination as! EventViewController
        destination.event = cell.event
    }
    

}
