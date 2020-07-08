//
//  ContactListTableViewController.swift
//  mobile-app-dev-hw3
//
//  Created by Abbe♡ on 2020/6/9.
//  Copyright © 2020 NTNU. All rights reserved.
//

import Foundation
import UIKit

class ContactListTableViewController: UITableViewController {
    
    var contactData: Contact? = nil
    var sectionData = Array(repeating: [String](), count: 26)
    let alphabet = "abcdefghijklmnopqrstuvwxyz".uppercased()
    let urlOfContactData = URL(string: "https://raw.githubusercontent.com/andy1213aa/NTNU-ios-programming-homework3/master/contact.json")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isEditing = true
        
        if let tmpUrl = urlOfContactData {
            URLSession.shared.dataTask(with: tmpUrl) {
                (data, res, err) in
                self.contactData = Contact(json: data!)
                self.contactData?.contacts.sort { $0.name < $1.name }
                
                var id = 0
                for char in self.alphabet {
                    for info in self.contactData!.contacts {
                        if info.name.hasPrefix(String(char)) {
                            self.sectionData[id].append(info.name)
                        }
                    }
                    id += 1
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }.resume()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 26
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionData[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if sectionData[section].count == 0 {
            return nil
        }
        let index = alphabet.index(alphabet.startIndex, offsetBy: section)
        return String(alphabet[index])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = sectionData[indexPath.section][indexPath.row]

        return cell
    }
    
    // editing

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section == destinationIndexPath.section {
            let moveCell = self.sectionData[sourceIndexPath.section][sourceIndexPath.row]
            sectionData[sourceIndexPath.section].remove(at: sourceIndexPath.row)
            sectionData[sourceIndexPath.section].insert(moveCell, at: destinationIndexPath.row)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
