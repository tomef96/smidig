//
//  AddEventViewController.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 12/10/18.
//  Copyright © 2018 Tom Fevang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class AddEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var numberPicker: UIPickerView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    var pickerData: [Int] = [Int]()
    private var datePicker: UIDatePicker?
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        var i = 0
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
    
    }
    
    @IBAction func addEvent(_ sender: Any) {
        var documentData = [String : Any]()
        
        documentData["title"] = titleTextField.text
        documentData["description"] = descriptionTextField.text
        documentData["place"] = placeTextField.text
        documentData["date"] = dateTextField.text
        documentData["spots"] = numberTextField.text
        documentData["owner"] = Auth.auth().currentUser?.uid
        
        var ref: DocumentReference? = nil
        ref = db.collection("events").addDocument(data: documentData) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        dateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberTextField.text = String(pickerData[row])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

}
