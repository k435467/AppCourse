//
//  EntryViewController.swift
//  mobile-app-dev-finalproject
//
//  Created by Abbe♡ on 2020/7/1.
//  Copyright © 2020 NTNU. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    var mainViewController: TasksTableViewController?
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask() {
        guard let titleText = titleTextField.text, !titleText.isEmpty else {
            return
        }
        let bodyText = bodyTextField.text ?? ""
        mainViewController?.tasks?.addItem(title: titleText, body: bodyText)
        mainViewController?.storeDataToFile()
            
        update?()
        navigationController?.popViewController(animated: true)
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
