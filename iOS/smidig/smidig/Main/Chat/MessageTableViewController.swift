//
//  MessageTableViewController.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 5/20/19.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit
import Firebase

class MessageTableViewController: UITableViewController {
    
    let db = Firestore.firestore()
    var chatId: String = "Not set"
    var messages = [Message]()
    
    @IBOutlet var messagesTableView: UITableView!
    let cellSpaceHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messagesTableView.sectionHeaderHeight = 0.0
        self.messagesTableView.estimatedRowHeight = 100
        db.collection("chats").document(chatId).collection("messages").addSnapshotListener { (QuerySnapshot, Error) in
            QuerySnapshot?.documentChanges.forEach({ (DocumentChange) in
                let text = DocumentChange.document.data()["message"]
                let author = DocumentChange.document.data()["Author"]
                let timestamp: Date = DocumentChange.document.data()["timestamp"] as! Date
                
                self.db.collection("users").document(author as! String).getDocument { (document, error) in
                    var username = "ukjent"
                    
                    if (document != nil) {
                        username = document?.data()?["username"] as? String ?? "Ukjent bruker"
                    }
                    
                    let message = Message.init(message: text as! String, author: username, date: Timestamp.init(date: timestamp))
                    
                    self.messages.append(message)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
        }
        
         self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        print("msg count: ")
        print(self.messages.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // messages = chat.messages
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.messages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! MessageTableViewCell
        
        let entry = self.messages[indexPath.row]
        let previous: Message?
        if (indexPath.row >= 1) {
            previous = self.messages[(indexPath.row - 1)]
        } else {
            previous = nil
        }
        
        cell.message = entry
        cell.messageLabel.text = entry.message
        cell.authorLabel.text = entry.author
        cell.messageLabel.layer.cornerRadius = 10
        cell.messageLabel.layer.masksToBounds = true
        
        if (previous != nil) {
            if (previous?.author == entry.author) {
                cell.authorLabel.text = " "
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = self.messages[indexPath.row]
        
        let height = cell.message.heightWithConstrainedWidth(width: 233.0, font: UIFont.systemFont(ofSize: 17.0))
        
        return height + 100.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
}
