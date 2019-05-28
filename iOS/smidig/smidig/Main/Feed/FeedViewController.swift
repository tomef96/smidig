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
