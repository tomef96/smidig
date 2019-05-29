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
        
        let button = UIBarButtonItem(image: .init(imageLiteralResourceName: "baseline_filter_list_black_24dp"), style: .plain, target: self, action: #selector(showFilter))
        button.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = button
        
    }
    
    @objc
    func showFilter() {
        performSegue(withIdentifier: "FilterSegue", sender: UIBarButtonItem())
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func fetchEvents() {
        db.collection("events").getDocuments { (documents, err) in
            for document in (documents?.documents)! {
                print("\(document.documentID) => \(document.data())")
                let owner: String = document["owner"]! as! String
                let place: String = document["place"]! as! String
                let description: String = document["description"]! as! String
                let date: String = document["date"]! as! String
                let spots: String = document["spots"]! as! String
                let title: String = document["title"]! as! String
                let category: String = document["category"]! as! String
                let subcategory: String = document["subcategory"] as! String
                let time: String = document["time"] as! String
                let id: String = document["id"]! as! String
                let participants = document["participants"] as! [String]
                
                self.events.append(Event(owner: owner, place: place, description: description, date: date, spots: spots, title: title, eventId: id, category: category, subcategory: subcategory, time: time, participants: participants))
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        events.removeAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchEvents()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
