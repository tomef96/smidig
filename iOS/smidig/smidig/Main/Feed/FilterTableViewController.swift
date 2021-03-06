//
//  FilterTableViewController.swift
//  smidig
//
//  Created by Tom Fevang on 27/05/2019.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController {
    
    var categories: [String] = []
    var preferences: Dictionary<String, Bool> = UserDefaults.standard.dictionary(forKey: "filterPreferences") as? Dictionary<String, Bool> ?? Dictionary<String, Bool>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for key in Event.categories.keys {
            categories.append(key)
        }
        categories.sort()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(preferences, forKey: "filterPreferences")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Event.categories.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as! FilterTableViewCell
        let category = categories[indexPath.row]
        cell.labelCategory.text = category
        cell.filterSwitch.category = category
        cell.filterSwitch.isOn = preferences[category] ?? true
        cell.filterSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        if cell.filterSwitch.isOn {
            cell.setCellBackgroundColor(for: cell.viewContainer, by: category)
        } else {
            cell.viewContainer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        
        return cell
    }
    
    @objc
    func switchChanged(filterSwitch: FilterSwitch) {
        guard let key = filterSwitch.category else {return}
        let value = filterSwitch.isOn
        let view = filterSwitch.superview!
        if value == false {
            view.backgroundColor = .lightGray
        } else {
            view.setCellBackgroundColor(for: view, by: filterSwitch.category!)
        }
        preferences[key] = value
    }
}
