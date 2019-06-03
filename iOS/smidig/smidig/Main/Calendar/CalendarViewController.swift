//
//  CalendarViewController.swift
//  smidig
//
//  Created by Tom Fevang on 13/12/2018.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit
import FirebaseFirestore

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let menuButton = UIBarButtonItem(image: .init(imageLiteralResourceName: "baseline_menu_black_24dp"), style: .plain, target: self, action: #selector(showMenu))
        menuButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc
    func showMenu() {
        performSegue(withIdentifier: "MenuSegue", sender: UIBarButtonItem())
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

class CardView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 16
    }
    
}
