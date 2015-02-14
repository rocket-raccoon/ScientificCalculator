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
    var hasEnteredNumber = false
    
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
        historyLabel.text = historyText + pressedButtonText
        switch pressedButtonText {
            case "Clear":
                clearScreen()
                isTyping = false
            case ".":
                if calculatorText.rangeOfString(pressedButtonText, options: nil, range: nil, locale: nil) == nil {
                    appendToScreen(calculatorText, s2: pressedButtonText)
                }
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "pi":
                if pressedButtonText == "pi" {
                    pressedButtonText = "\(M_PI)"
                }
                if isTyping {
                    appendToScreen(calculatorText, s2: pressedButtonText)
                } else {
                    appendToScreen("", s2: pressedButtonText)
                    isTyping = true
                }
            case "✖️", "➕", "➖", "➗":
                if isTyping && hasEnteredNumber {
                    let calculatorDouble = NSString(string: calculatorText).doubleValue
                    calculatorModel.pushOperand(calculatorDouble)
                    calculatorModel.pushOperation(pressedButtonText)
                    let result = calculatorModel.calculate()
                    numberLabel.text = "\(result)"
                }
                isTyping = false
                println(calculatorModel.opStack)
            case "√", "sin", "cos":
                if hasEnteredNumber {
                    calculatorModel.pushOperation(pressedButtonText)
                    let result = calculatorModel.calculate()
                    numberLabel.text = "\(result)"
                    println(calculatorModel.opStack)
                }
            case "⏎":
                isTyping = false
                hasEnteredNumber = true
                let calculatorDouble = NSString(string: calculatorText).doubleValue
                if calculatorModel.opStack.isEmpty {
                    calculatorModel.pushOperand(calculatorDouble)
                } else {
                    calculatorModel.opStack.removeLast()
                    calculatorModel.pushOperand(calculatorDouble)
                }
                println(calculatorModel.opStack)
            default:
                numberLabel.text = pressedButtonText
        }
    }
    
    //Resets the screen back to zero
    func clearScreen() {
        numberLabel.text = "0"
        historyLabel.text = ""
        calculatorModel.opStack.removeAll(keepCapacity: false)
    }
    
    //Sets the calculator text to be the concatenation of 2 strings s1 and s2
    func appendToScreen(s1: String, s2: String) {
        numberLabel.text = s1 + s2
    }
    
}






