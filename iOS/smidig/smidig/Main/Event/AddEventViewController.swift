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
    @IBOutlet weak var timeTextField: UITextField!
    var pickerData: [Int] = [Int]()
    private var datePicker: UIDatePicker?
    private var timePicker: UIDatePicker?
    var categoryData: [String] = [String]()
    var subcategoryData: [String] = [String]()
    let db = Firestore.firestore()
    var event: Event?
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var subcategoryPicker: UIPickerView!
    
    @IBOutlet weak var subcategoryTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    var appUser: AppUser = AppUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.underlined()
        numberTextField.underlined()
        dateTextField.underlined()
        placeTextField.underlined()
        descriptionTextField.underlined()
        categoryTextField.underlined()
        subcategoryTextField.underlined()
        timeTextField.underlined()
        
        createBtn.layer.cornerRadius = 0.5 * createBtn.bounds.size.width
        createBtn.clipsToBounds = true
        
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        timePicker?.addTarget(self, action: #selector(timeChanged(timePicker:)), for: .valueChanged)
        
        var i = 0
        repeat {
            pickerData.append(i)
            i = i + 1
        } while i < 101
        
        categoryData.append(contentsOf: Event.categories.keys)
        //subcategoryData.append(contentsOf: Event.categories["Sport"]!)
        
        self.numberPicker.delegate = self
        self.numberPicker.dataSource = self
        
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        self.subcategoryPicker.delegate = self
        self.subcategoryPicker.dataSource = self
        
        categoryPicker.removeFromSuperview()
        categoryTextField.inputView = categoryPicker
        
        subcategoryPicker.removeFromSuperview()
        subcategoryTextField.inputView = subcategoryPicker
        
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
    }
    
    @IBAction func addEvent(_ sender: Any) {
        var documentData = [String : Any]()
        
        if (titleTextField.text != "" && descriptionTextField.text != "" && placeTextField.text != "" && dateTextField.text != "" && numberTextField.text != "" && Auth.auth().currentUser?.uid != nil && timeTextField.text != "" && categoryTextField.text != "" && subcategoryTextField.text != "") {
            
            documentData["title"] = titleTextField.text
            documentData["description"] = descriptionTextField.text
            documentData["place"] = placeTextField.text
            documentData["date"] = dateTextField.text
            documentData["spots"] = numberTextField.text
            documentData["owner"] = Auth.auth().currentUser?.uid
            documentData["time"] = timeTextField.text
            documentData["category"] = categoryTextField.text
            documentData["subcategory"] = subcategoryTextField.text
            documentData["participants"] = [Auth.auth().currentUser!.uid]
            
            /*let schedule = db.collection("users").document(Auth.auth().currentUser!.uid).collection("schedule")*/
            
            
            var ref: DocumentReference? = nil
            ref = db.collection("events").addDocument(data: documentData) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    ref?.setData(["id" : ref!.documentID], merge: true)
                    self.event = Event(owner: documentData["owner"] as! String, place: documentData["place"] as! String, description: documentData["description"] as! String, date: documentData["date"] as! String, spots: documentData["spots"] as! String, title: documentData["title"] as! String, eventId: (ref?.documentID)!, category: documentData["category"] as! String, subcategory: documentData["subcategory"] as! String, time: documentData["time"] as! String, participants: documentData["participants"] as! [String])
                    
                   let eventReference = self.db.document("events/\(ref!.documentID)")
                    self.db.collection("users").document(Auth.auth().currentUser!.uid).collection("schedule").addDocument(data: ["event": eventReference])
                    self.performSegue(withIdentifier: "eventAdded", sender: self)
                }
            }
            
            
        } else {
            print("Alle feltene er ikke fylt ut")
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
    
    @objc func timeChanged(timePicker: UIDatePicker) {
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        timeTextField.text = timeFormatter.string(from: timePicker.date)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == numberPicker) {
            return pickerData.count
        } else if (pickerView == categoryPicker) {
            return categoryData.count
        } else if (pickerView == subcategoryPicker) {
            return subcategoryData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == numberPicker) {
            return String(pickerData[row])
        } else if (pickerView == categoryPicker) {
             return String(categoryData[row])
        } else if (pickerView == subcategoryPicker) {
            return String(subcategoryData[row])
        }
        return "Test"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == numberPicker) {
           numberTextField.text = String(pickerData[row])
        } else if (pickerView == categoryPicker) {
            categoryTextField.text = String(categoryData[row])
            subcategoryTextField.text = ""
            subcategoryData = Event.categories[categoryTextField.text!]!
        } else if (pickerView == subcategoryPicker) {
            subcategoryTextField.text = String(subcategoryData[row])
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let destination = segue.destination as! EventViewController
        destination.event = event
    }

}

extension UITextField {
    func underlined(){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
