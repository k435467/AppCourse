//
//  TaskViewController.swift
//  mobile-app-dev-finalproject
//
//  Created by Abbe♡ on 2020/7/1.
//  Copyright © 2020 NTNU. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    var task: String?
    var body: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = task
        bodyLabel.text = body
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
