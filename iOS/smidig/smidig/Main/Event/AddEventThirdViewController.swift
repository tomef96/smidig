//
//  AddEventThirdViewController.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 6/4/19.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit
import Firebase
import SwiftMessages

class AddEventThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        parentVC = self.parent as? CreateEventPageViewController
        
        previewTitle.text = parentVC?.event?.title ?? "Title er ikke satt"
        previewLocation.text = parentVC?.event?.place ?? "Lokasjon er ikke satt"
        previewDate.text = EventTableModel.formatDate(date: (parentVC?.event!.date)!) ?? "Lokasjon er ikke satt"
        previewTime.text = parentVC?.event?.time ?? "Tid er ikke satt"
        previewIcon.image = UIImage(named: parentVC?.event?.category ?? "Annet")
        previewCard.setCellBackgroundColor(for: previewCard, by: parentVC?.event?.category ?? "Annet")
        // Do any additional setup after loading the view.
    }
    
    weak var parentVC: CreateEventPageViewController?
    let db = Firestore.firestore()
    var event: Event?
    
    @IBOutlet weak var previewTitle: UILabel!
    @IBOutlet weak var previewLocation: UILabel!
    @IBOutlet weak var previewDate: UILabel!
    @IBOutlet weak var previewTime: UILabel!
    @IBOutlet weak var previewIcon: UIImageView!
    @IBOutlet weak var previewCard: CardView!
    
    @IBAction func goToPrevious(_ sender: Any) {
        parentVC?.setViewControllers([(parentVC?.subViewControllers[1])!], direction: UIPageViewController.NavigationDirection.reverse, animated: true, completion: nil)
        
    }
    @IBAction func addEvent(_ sender: Any) {
        var documentData = [String : Any]()
        
        if (event?.title != "" && event?.description != "" && event?.place != "" && event?.date != "" && event?.spots != "" && Auth.auth().currentUser?.uid != nil && event?.time != "" && event?.category != "") {
            
            documentData["title"] = parentVC?.event?.title
            documentData["description"] = parentVC?.event?.description
            documentData["place"] = parentVC?.event?.place
            documentData["date"] = parentVC?.event?.date
            documentData["spots"] = parentVC?.event?.spots
            documentData["owner"] = Auth.auth().currentUser?.uid
            documentData["time"] = parentVC?.event?.time
            documentData["category"] = parentVC?.event?.category
            documentData["participants"] = [Auth.auth().currentUser!.uid]
            
            let schedule = db.collection("users").document(Auth.auth().currentUser!.uid).collection("schedule")
            
            
            var ref: DocumentReference? = nil
            ref = db.collection("events").addDocument(data: documentData) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    ref?.setData(["id" : ref?.documentID], merge: true)
                    self.event = Event(owner: documentData["owner"] as! String, place: documentData["place"] as! String, description: documentData["description"] as! String, date: documentData["date"] as! String, spots: documentData["spots"] as! String, title: documentData["title"] as! String, eventId: (ref?.documentID)!, category: documentData["category"] as! String, time: documentData["time"] as! String, participants: documentData["participants"] as! [String])
                    
                    let eventReference = self.db.document("events/\(ref!.documentID)")
                    self.db.collection("users").document(Auth.auth().currentUser!.uid).collection("schedule").addDocument(data: ["event": eventReference])
                    
                    self.parentVC?.event?.reset()
                    
                    self.performSegue(withIdentifier: "eventAdded", sender: self)
                }
            }
            
            
        } else {
            let view = MessageView.viewFromNib(layout: .cardView)
            view.configureTheme(.warning)
            view.button?.isHidden = true
            view.configureContent(title: "Oops!", body: "Det ser ut som du har glemt å fylle ut et skjema.")
            SwiftMessages.show(view: view)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let destination = segue.destination as! EventViewController
        destination.event = event
    }

}
