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
import SwiftMessages

class EventViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate;

        // Do any additional setup after loading the view.
        //eventView.populate(event: event)
        populate(event: event)
        
        if event.participants.contains(Auth.auth().currentUser!.uid) {
            joinButton.setTitle("Forlat", for: .normal)
            joinButton.backgroundColor = #colorLiteral(red: 0.8666666667, green: 0.3921568627, blue: 0.3921568627, alpha: 1)
            joinButton.setTitleColor(.white, for: .normal)
        }
        
        addShadow(view: joinButton)
        addShadow(view: chatButton)
    }
    
    func addShadow(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 3.0
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 1, height: 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    var event: Event!
    
    @IBOutlet weak var chatButton: RoundButton!
    
    @IBOutlet weak var eventView: EventScrollView!
    
    @IBOutlet weak var joinButton: UIButton!
    
    @IBAction func joinEvent(_ sender: UIButton) {
        if sender.titleLabel?.text != "Forlat" {
            event.join()
            
            let view = MessageView.viewFromNib(layout: .cardView)
            view.configureTheme(.success)
            view.button?.isHidden = true
            view.configureContent(title: "Suksess!", body: "Du er nå påmeldt eventet \(event.title)!")
            SwiftMessages.show(view: view)
            
            populate(event: event)
            joinButton.setTitle("Forlat", for: .normal)
            joinButton.backgroundColor = #colorLiteral(red: 0.8666666667, green: 0.3921568627, blue: 0.3921568627, alpha: 1)
            joinButton.setTitleColor(.white, for: .normal)
        } else {
            leaveEvent(sender)
        }
    }
    
    @IBOutlet weak var leaveButton: UIButton!
    
    @IBAction func leaveEvent(_ sender: UIButton) {
        event.leave()
        
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.success)
        view.button?.isHidden = true
        view.configureContent(title: "Suksess!", body: "Du forlot eventet \(event.title)!")
        SwiftMessages.show(view: view)
        
        populate(event: event)
        //leaveButton.isHidden = true
        joinButton.setTitle("Bli med", for: .normal)
        joinButton.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.7960784314, blue: 0.5529411765, alpha: 1)
        joinButton.setTitleColor(.darkText, for: .normal)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destination = segue.destination as! ChatViewController
            destination.chatId = event.eventId
    }
    @IBOutlet weak var topColor: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPlace: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelSpots: UILabel!
    
    var eventId: String = ""
    
    func populate(event: Event) {
        labelTitle.text = event.title
        labelDescription.text = event.description
        labelSpots.text = String(event.participants.count) + "/" + event.spots
        labelPlace.text = event.place
        labelDate.text = EventTableModel.formatDate(date: event.date)
        labelTime.text = event.time
        eventId = event.eventId
        topColor.setCellBackgroundColor(for: topColor, by: event.category)
    }
}



class EventScrollView: UIScrollView {
    
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
        layer.cornerRadius = 8
    }
}
