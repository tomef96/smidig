//
//  AddEventViewController.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 12/10/18.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit
import Firebase

class AddEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var numberPicker: UIPickerView!
    var pickerData: [Int] = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var i = 0
        repeat {
            pickerData.append(i)
            i = i + 1
        } while i < 101
        
        self.numberPicker.delegate = self
        self.numberPicker.dataSource = self
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }

}
