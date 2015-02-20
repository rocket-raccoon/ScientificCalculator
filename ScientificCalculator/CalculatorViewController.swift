//
//  CalculatorViewController.swift
//  ScientificCalculator
//
//  Created by Alberto Benavides on 2/7/15.
//  Copyright (c) 2015 rocket-raccoon. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var historyLabel: UILabel!
    var numberLabel: UILabel!
    var calculatorModel = CalculatorModel()
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Create the calculator view on screen
        var (l1, l2) = CalculatorView().setupTextLabels(view, vc: self)
        historyLabel = l2
        numberLabel = l1
        CalculatorView().setupButtons(view, vc: self, numberLabel: numberLabel, historyLabel: historyLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //This routes the button press on the calculator to the correct function to process it
    func press(sender: UIButton) {
        
        var pressedButtonText = sender.titleLabel!.text!
        var calculatorText = numberLabel.text!
        var historyText = historyLabel.text!
        
        switch pressedButtonText {
            case "C":
                clearScreen()
                calculatorModel.variableValues.removeValueForKey("M")
                isTyping = false
            case ".":
                if calculatorText.rangeOfString(pressedButtonText, options: nil, range: nil, locale: nil) == nil {
                    numberLabel.text = calculatorText + pressedButtonText
                }
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                if isTyping {
                    numberLabel.text = calculatorText + pressedButtonText
                } else {
                    numberLabel.text = pressedButtonText
                    isTyping = true
                }
            case "✖️", "➕", "➖", "➗", "√", "sin", "cos":
                if isTyping {
                    let calculatorDouble = NSString(string: calculatorText).doubleValue
                    calculatorModel.pushOperand(calculatorDouble)
                    isTyping = false
                }
                calculatorModel.pushOperation(pressedButtonText)
                let result = calculatorModel.calculate()
                if let interpretableResult = result {
                    numberLabel.text = "\(interpretableResult)"
                } else {
                    //clearScreen()
                    numberLabel.text = ""
                }
            case "pi", "M":
                if isTyping {
                    let calculatorDouble = NSString(string: calculatorText).doubleValue
                    calculatorModel.pushOperand(calculatorDouble)
                    isTyping = false
                }
                calculatorModel.pushOperand(pressedButtonText)
                let result = calculatorModel.calculate()
                if let interpretableResult = result {
                    numberLabel.text = "\(interpretableResult)"
                } else {
                    //clearScreen()
                    numberLabel.text = ""
                }
            case "⏎":
                isTyping = false
                let calculatorDouble = NSString(string: calculatorText).doubleValue
                calculatorModel.pushOperand(calculatorDouble)
            case "->M":
                calculatorModel.variableValues["M"] = NSString(string: calculatorText).doubleValue
                isTyping = false
                let result = calculatorModel.calculate()
                if let interpretableResult = result {
                    numberLabel.text = "\(interpretableResult)"
                } else {
                    //clearScreen()
                    numberLabel.text = ""
                }
            default:
                break
        }
        //println(calculatorModel.opStack)
        println(calculatorModel.opHistory)
        println(calculatorModel.description)
        
        historyLabel.text = calculatorModel.description + "="
    }
    
    //Resets the screen back to zero
    func clearScreen() {
        numberLabel.text = "0"
        historyLabel.text = ""
        calculatorModel.opStack.removeAll(keepCapacity: false)
        calculatorModel.opHistory.removeAll(keepCapacity: false)
    }
    
}






