//
//  EventViewController.swift
//  smidig
//
//  Created by Tom Fevang on 10/12/2018.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit
import Firebase

class EventViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //event = Event(owner: "owner", place: "place", description: "description", date: "date", spots: "spots", title: "title")
        eventView.populate(event: event!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    var event: Event?
    
    @IBOutlet weak var eventView: EventView!
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

class EventView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var spotsLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    func populate(event: Event) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        spotsLabel.text = event.spots
        placeLabel.text = event.place
    }
    
    @IBAction func touchJoinBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func touchLeaveBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func touchChatBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func touchReportBtn(_ sender: UIButton) {
        
    }
}
