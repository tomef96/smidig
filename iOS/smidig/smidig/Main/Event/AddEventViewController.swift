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

private let reuseIdentifier = "CreateEventCollectionViewCell"

class AddEventViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let categories = ["Friluft" : UIColor(red: 149/255, green: 210/255, blue: 107/255, alpha: 1),
                      "Film og TV" : UIColor(red: 247/255, green: 86/255, blue: 82/255, alpha: 1),
                      "Gaming" : UIColor(red: 247/255, green: 199/255, blue: 88/255, alpha: 1),
                      "Hobby" : UIColor(red: 255/255, green: 105/255, blue: 180/255, alpha: 1),
                      "Kultur" : UIColor(red: 85/255, green: 26/255, blue: 139/255, alpha: 1),
                      "Musikk" : UIColor(red: 93/255, green: 17/255, blue: 247/255, alpha: 1),
                      "Sport" : UIColor(red: 66/255, green: 193/255, blue: 247/255, alpha: 1),
                      "Underholdning" : UIColor(red: 218/255, green: 64/255, blue: 122/255, alpha: 1),
                      "Annet" : UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1),
                      "Skole" : UIColor(red: 240/255, green: 127/255, blue: 90/255, alpha: 1)]
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CreateEventCollectionViewCell
        
        let category = Array(self.categories.keys)[indexPath.row]

        cell.ctgLabel.text = category
        cell.ctgLabel.adjustsFontSizeToFitWidth = true
        let image = UIImage(named: category)?.withRenderingMode(.alwaysTemplate)
        cell.ctgImage.image = image
        cell.ctgImage.tintColor = UIColor.white
        cell.backgroundColor = self.categories[category]
        cell.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let category = Array(self.categories.keys)[indexPath.row]
        
        self.category = category
    }
    
    @IBAction func nextButtonOne(_ sender: Any) {
        
        if (!(self.titleTextField.text?.isEmpty)! && !self.category.isEmpty && !self.descriptionTextField.text.isEmpty) {
            
            event?.title = self.titleTextField.text!
            event?.category = self.category
            event?.description = self.descriptionTextField.text
            
            parentVC?.event = self.event
            parentVC?.setViewControllers([(parentVC?.subViewControllers[1])!], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
            
        } else {
            print("Alle feltene er ikke fylt ut")
        }
        
    }
    
    weak var parentVC: CreateEventPageViewController?
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    var category = ""
    var event: Event?
 
    var appUser: AppUser = AppUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.event = Event(owner: "", place: "", description: "", date: "", spots: "", title: "", eventId: "", category: "", subcategory: "", time: "", participants: [])
        
        parentVC = self.parent as? CreateEventPageViewController
        
        let cellNib = UINib(nibName: "CreateEventCollectionViewCell", bundle: nil)
        eventCollectionView!.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        
        eventCollectionView.delegate = self
        eventCollectionView.dataSource = self
        
        titleTextField.addShadow()
        setupTextFields()
        
    }
    
    func setupTextFields() {
        
        self.descriptionTextField.backgroundColor = UIColor.white // Use anycolor that give you a 2d look.

        self.descriptionTextField.layer.cornerRadius = 8
        
        self.descriptionTextField.layer.borderWidth = 0.25
        self.descriptionTextField.layer.borderColor = UIColor.gray.cgColor
        
        self.descriptionTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        self.descriptionTextField.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.descriptionTextField.layer.shadowColor = UIColor.black.cgColor //Any dark color
        self.descriptionTextField.layer.shadowRadius = 2.0
        self.descriptionTextField.layer.shadowOpacity = 0.25
        self.descriptionTextField.clipsToBounds = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let destination = segue.destination as! AddEventSecondViewController
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
    func addShadow() {
        
        self.borderStyle = .none
        backgroundColor = .white
        
        layer.cornerRadius = 8
        
        layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        layer.borderWidth = 0.25
        layer.shadowColor = UIColor.black.cgColor //Any dark color
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        clipsToBounds = false
        
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
        
        
        
    }
}
