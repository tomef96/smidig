//
//  AddEventSecondViewController.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 6/4/19.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit
import SwiftMessages

class AddEventSecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var numberPicker: UIPickerView!
    
    var pickerData: [Int] = [Int]()
    private var datePicker: UIDatePicker?
    private var timePicker: UIDatePicker?
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    
    weak var parentVC: CreateEventPageViewController?
    
    var event: Event?
    
    @IBAction func nextPage(_ sender: Any) {
        
        if (!(self.numberTextField.text?.isEmpty)! && !(self.dateTextField.text?.isEmpty)!
            && !(self.placeTextField.text?.isEmpty)! && !(self.timeTextField.text?.isEmpty)!) {
            event?.spots = numberTextField.text!
            event?.date = dateTextField.text!
            event?.time = timeTextField.text!
            event?.place = placeTextField.text!
            
            parentVC?.event = self.event
            
            parentVC?.setViewControllers([(parentVC?.subViewControllers[2])!], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
            
        } else {
            let view = MessageView.viewFromNib(layout: .cardView)
            view.configureTheme(.warning)
            view.button?.isHidden = true
            view.configureContent(title: "Oops!", body: "Alle feltene er ikke fylt ut.")
            SwiftMessages.show(view: view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        numberTextField.text = parentVC?.event?.spots
        placeTextField.text = parentVC?.event?.place
    }
    
    @IBAction func previousPage(_ sender: Any) {
        parentVC?.setViewControllers([(parentVC?.subViewControllers[0])!], direction: UIPageViewController.NavigationDirection.reverse, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupHideKeyboardOnTap()
        
        parentVC = self.parent as? CreateEventPageViewController
        self.event = parentVC?.event
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        timePicker?.addTarget(self, action: #selector(timeChanged(timePicker:)), for: .valueChanged)
        
        var i = 2
        repeat {
            pickerData.append(i)
            i = i + 1
        } while i < 101
        
        self.numberPicker.delegate = self
        self.numberPicker.dataSource = self

        numberPicker.removeFromSuperview()
        numberTextField.inputView = numberPicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        dateTextField.inputView = datePicker
        timeTextField.inputView = timePicker
        
        let date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = dateFormatter.string(from: date)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeTextField.text = timeFormatter.string(from: date)
        
        dateTextField.addShadow()
        timeTextField.addShadow()
        numberTextField.addShadow()
        placeTextField.addShadow()
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        dateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func timeChanged(timePicker: UIDatePicker) {
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        timeTextField.text = timeFormatter.string(from: timePicker.date)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == numberPicker) {
            return pickerData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == numberPicker) {
            return String(pickerData[row])
        }
        return "Test"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == numberPicker) {
            numberTextField.text = String(pickerData[row])
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
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
