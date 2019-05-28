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
        setCellBackgroundColor(for: cell.viewContainer, by: category)
        return cell
    }
    
    @objc
    func switchChanged(filterSwitch: FilterSwitch) {
        guard let key = filterSwitch.category else {return}
        let value = filterSwitch.isOn
        preferences[key] = value
    }
    
    private func setCellBackgroundColor(for view: UIView, by category: String) {
        switch category {
        case "Sport":
            view.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) // #95D26B
        case "Gaming":
            view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1) // #F07F5A
        case "Meet Up":
            view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1) // #42C1F7
        case "Underholdning":
            view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1) // #F7C758
        case "Studering":
            view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) // #DA407A
        case "Uteliv":
            view.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) // #5D11F7
        case "Friluft":
            view.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.8039215686, blue: 0.4980392157, alpha: 1) // #5ACD7F
        default:
            view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.337254902, blue: 0.3215686275, alpha: 1) // #F25652
        }
    }
}
