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
    
    @IBOutlet weak var debugLable: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    var brain = CalculatorBrain()
    
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
    
    @IBAction func operate(_ sender: UIButton) {
        let operation = sender.currentTitle!
        
        print("operation = \(operation)")
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let result = brain.performOperation(symbol: operation){
            displayValue = result
            enter()
        } else {
            displayValue = 0
            enter()
        }

/*
        switch operation {
        case "×":
            performOperation(operation: multiply)
            //            if operandStack.count >= 2 {
            //                displayValue = operandStack.removeLast() * operandStack.removeLast()
            //                enter()
            //            }
        case "÷":
            performOperation(operation: {
                (op1: Double, op2: Double) -> Double in
                return op1 / op2
            })
            //            if operandStack.count >= 2 {
            //                displayValue = operandStack.removeLast() / operandStack.removeLast()
            //                enter()
            //            }
        case "+":
            performOperation(operation: { (op1, op2) in op1 + op2 })
            //            performOperation(operation: {
            //                (op1, op2) in
            //                return op1 + op2
            //            })
            //
            //            if operandStack.count >= 2 {
            //                displayValue = operandStack.removeLast() + operandStack.removeLast()
            //                enter()
            //            }
        case "−":
            // 只有一个参数时可以不需要括号
            performOperation{ $0 - $1 }
            //            最后一个参数可以放括号外
            //            performOperation(){ $0 - $1 }
            //
            //            performOperation (operation: { $0 - $1 })
            //
            //            if operandStack.count >= 2 {
            //                displayValue = operandStack.removeLast() - operandStack.removeLast()
            //                enter()
            //            }
            
        case "√":
            performOperation {sqrt($0)}
        default: break
        }
 */
    }
/*
    func performOperation(operation: (Double,Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    @nonobjc
     func performOperation(operation: (Double) -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func multiply(op1: Double, op2: Double) -> Double{
        return op1 * op2
    }

    // var operandStack:Array<Double> = Array<Double>()
    var operandStack = Array<Double>()
*/
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(operand: displayValue){
            displayValue = result
        } else {
            displayValue = 0
        }
/*
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
        debugLable.text = "operandStack = \(operandStack)"
*/
    }
    
    var displayValue: Double{
        get{
            return NumberFormatter().number(from: display.text!)!.doubleValue
        }
        set(newValue2){
            display.text = "\(newValue2)"
            print("newValue = \(newValue2)")
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
}

