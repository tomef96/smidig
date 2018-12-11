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
    }
    
    func join(event: Event) {
        // TODO: Gjør det mulig å melde seg på et event
        //User.getCurrentUser.addToSchedule(event)
    }
    
    func leave(event: Event) {
        // TODO: Gjøre det mulig å melde seg av et event
        //User.getCurrentUser.removeFromSchedule(event)
    }
    
    func chat(with author: Event) {
        // TODO: Gjør det mulig å sende melding til vert
        //Chat.init(with: event.author, and: User.getCurrentUser)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
