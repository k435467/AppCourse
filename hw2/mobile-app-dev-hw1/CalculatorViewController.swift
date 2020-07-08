//
//  ViewController.swift
//  mobile-app-dev-hw1
//
//  Created by Abbe♡ on 2020/4/24.
//  Copyright © 2020 NTNU. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    var calculator = Calculator()
    @IBOutlet weak var displayLbl: UILabel!
    
    @IBAction func touchBtn(_ sender: UIButton) {
        calculator.touch(btn: sender.currentTitle!)
        displayLbl.text = calculator.displayStr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

