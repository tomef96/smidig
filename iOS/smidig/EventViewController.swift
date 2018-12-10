//
//  EventViewController.swift
//  smidig
//
//  Created by Tom Fevang on 10/12/2018.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func signUp(user: String, for event: Event) {
        // TODO: Gjør det mulig å melde seg på en event
    }
    
    func chat(with author: Event) {
        // TODO: Gjør det mulig å sende melding til vert
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
