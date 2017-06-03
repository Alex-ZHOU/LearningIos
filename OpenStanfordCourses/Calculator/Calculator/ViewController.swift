//
//  ViewController.swift
//  Calculator
//
//  Created by AlexZHOU on 22/05/2017.
//  Copyright © 2017 AlexZHOU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    @IBAction func appendDigit(_ sender: UIButton) {
        let digit = sender.currentTitle
        
        debugPrint("digit = \(String(describing: digit))")
        debugPrint("digit = \(digit!)")

        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit!
        } else {
            display.text = digit!
            userIsInTheMiddleOfTypingANumber = true
        }
        
        
    }
}

