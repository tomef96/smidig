//
//  EventViewController.swift
//  smidig
//
//  Created by Tom Fevang on 10/12/2018.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class EventViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate;

        // Do any additional setup after loading the view.
        eventView.populate(event: event)
        if event.participants.contains(Auth.auth().currentUser!.uid) {
            joinButton.setTitle("Påmeldt", for: UIControl.State.normal)
            joinButton.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    var event: Event!
    
    @IBOutlet weak var eventView: EventView!
    
    @IBOutlet weak var joinButton: UIButton!
    
    @IBAction func joinEvent(_ sender: UIButton) {
        event.join()
        postAlert(title: "Lagt til i kalender", message: "😃")
        eventView.populate(event: event)
        leaveButton.isHidden = false
        joinButton.setTitle("Påmeldt", for: UIControl.State.normal)
        joinButton.isEnabled = false
    }
    
    @IBOutlet weak var leaveButton: UIButton!
    
    @IBAction func leaveEvent(_ sender: UIButton) {
        event.leave()
        postAlert(title: "Det var synd", message: "😔")
        eventView.populate(event: event)
        leaveButton.isHidden = true
        joinButton.setTitle("Bli med", for: UIControl.State.normal)
        joinButton.isEnabled = true
    }
    
    @IBAction func goToChat(_ sender: Any) {
        
    }
    
    func postAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            alert.dismiss(animated: true, completion: nil)
        })
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destination = segue.destination as! ChatViewController
            destination.chatId = event.eventId
    }
}

class EventView: UIView {
    
    let db = Firestore.firestore()
    var eventId: String = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var spotsLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    func populate(event: Event) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        spotsLabel.text = String(event.participants.count) + "/" + event.spots
        placeLabel.text = event.place
        dateLabel.text = event.date
        timeLabel.text = event.time
        eventId = event.eventId
    }
}

class RoundButton : UIButton {
    
    var selectedState: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //layer.borderWidth = 2 / UIScreen.main.nativeScale
        //layer.borderColor = UIColor.white.cgColor
    }
    
    
    override func layoutSubviews(){
        super.layoutSubviews()
        layer.cornerRadius = 4
    }
}
