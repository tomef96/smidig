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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! EventTableViewCell
        
        if feed.filteredEvents.isEmpty {
            return cell
        }
        let entry = feed.filteredEvents[indexPath.row]
        cell.event = entry
        cell.eventTitleLabel.text = entry.title
        cell.spotsLabel?.text = String((Int(entry.spots)! - entry.participants.count)) + " plasser"
        cell.descriptionLabel?.text = entry.description
        cell.placeLabel.text = entry.place
        cell.eventId = entry.eventId
        cell.subcategoryLabel?.text = entry.subcategory
        cell.categoryLabel?.text = entry.category
        cell.timeLabel.text = entry.time
        cell.dateLabel?.text = entry.date
        cell.setCellBackgroundColor(for: cell.cardView, by: entry.category)
        cell.selectionStyle = .none
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
