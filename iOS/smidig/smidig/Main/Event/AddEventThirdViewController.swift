//
//  AddEventThirdViewController.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 6/4/19.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit
import Firebase

class AddEventThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        parentVC = self.parent as? CreateEventPageViewController
        // Do any additional setup after loading the view.
    }
    
    weak var parentVC: CreateEventPageViewController?
    let db = Firestore.firestore()
    var event: Event?
    
    @IBAction func goToPrevious(_ sender: Any) {
        parentVC?.setViewControllers([(parentVC?.subViewControllers[1])!], direction: UIPageViewController.NavigationDirection.reverse, animated: true, completion: nil)
        
    }
    @IBAction func addEvent(_ sender: Any) {
        /*var documentData = [String : Any]()
        
        if (event?.title != "" && event?.description != "" && event?.place != "" && event?.date != "" && event?.spots != "" && Auth.auth().currentUser?.uid != nil && event?.time != "" && event?.category != "") {
            
            documentData["title"] = event?.title
            documentData["description"] = event?.description
            documentData["place"] = event?.place
            documentData["date"] = event?.date
            documentData["spots"] = event?.spots
            documentData["owner"] = Auth.auth().currentUser?.uid
            documentData["time"] = event?.time
            documentData["category"] = event?.category
            documentData["participants"] = [Auth.auth().currentUser!.uid]
            
            /*let schedule = db.collection("users").document(Auth.auth().currentUser!.uid).collection("schedule")*/
            
            
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
                    self.performSegue(withIdentifier: "eventAdded", sender: self)
                }
            }
            
            
        } else {
            print("Alle feltene er ikke fylt ut")
        }*/
        print("Event data: \(parentVC?.event?.title)")
        print("Event data: \(parentVC?.event?.spots)")
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
