//
//  FeedViewController.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 12/12/18.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class FeedViewController: UITableViewController {

    let data = Data()
    
    let db = Firestore.firestore()
    var events = [Event]()
    
    let cellSpacingHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }

    func fetchEvents() {
        events.removeAll()
        
        db.collection("events").getDocuments { (documents, err) in
            for document in (documents?.documents)! {
                print("\(document.documentID) => \(document.data())")
                let owner: String = document["owner"]! as! String
                let place: String = document["place"]! as! String
                let description: String = document["description"]! as! String
                let date: String = document["date"]! as! String
                let spots: String = document["spots"]! as! String
                let title: String = document["title"]! as! String
                let id: String = document["id"]! as! String
                
                self.events.append(Event(owner: owner, place: place, description: description, date: date, spots: spots, title: title, eventId: id))
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchEvents()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! EventTableViewCell
        let entry = self.events[indexPath.row]
        //let image = UIImage(named: "LogoPlaceholder.png")
        //cell.eventImageView.image = image
        cell.eventTitleLabel.text = entry.title
        cell.spotsLabel.text = entry.spots
        cell.descriptionLabel.text = entry.description
        cell.placeLabel.text = entry.place
        cell.eventId = entry.eventId
        print(entry.title)
        return cell
    }
    
    /*override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }*/
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! EventTableViewCell
        let title = cell.eventTitleLabel.text
        let spots = cell.spotsLabel.text
        let description = cell.descriptionLabel.text
        let place = cell.placeLabel.text
        let id = cell.eventId
        let event = Event(owner: "owner", place: place!, description: description!, date: "date", spots: spots!, title: title!, eventId: id!)
        
        let destination = segue.destination as? EventViewController
        destination?.event = event
    }
    

}
