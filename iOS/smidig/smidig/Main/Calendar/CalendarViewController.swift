//
//  CalendarViewController.swift
//  smidig
//
//  Created by Tom Fevang on 13/12/2018.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let event = Event(owner: "Jan", place: "Oslo", description: "Desc", date: "Date", spots: "Spots", title: "Title")
        events = [event]
    }
    
    var events: [Event]?
    var cells: [CalendarTableViewCell]?
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    

}

class CalendarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var totalSpotsLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var spotsLabel: UILabel!
    
    func populate(event: Event) {
        titleLabel.text = event.title
        placeLabel.text = event.place
        
        descriptionLabel.text = event.description
        spotsLabel.text = event.spots
        
    }
}
