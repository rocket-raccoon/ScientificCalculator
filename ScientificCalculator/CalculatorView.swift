//
//  CalculatorView.swift
//  ScientificCalculator
//
//  Created by Alberto Benavides on 2/10/15.
//  Copyright (c) 2015 rocket-raccoon. All rights reserved.
//
//  This class is responsible for setting up all the buttons and views of the calculator

import Foundation
import UIKit

class CalculatorView {
    
    //This 2D grid will describe the layout of the buttons on the calculator view
    let buttonGrid =   [["1", "2", "3", "✖️", "√"],
                        ["4", "5", "6", "➕", "sin"],
                        ["7", "8", "9", "➖", "cos"],
                        [".", "0", "⏎", "➗", "pi"]]
    
    //Creates the label at the top of the screen that holds all the numbers for the calculator
    func setupNumberLabel(v: UIView, vc: CalculatorViewController) -> UILabel {
        //Instantiate the textlabel
        var textLabel = UILabel(frame: CGRect())
        textLabel.text = "0"
        textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        textLabel.font = UIFont(name: textLabel.font.fontName, size: 32.0)
        textLabel.textAlignment = .Right
        textLabel.layer.borderWidth = 1.0
        textLabel.backgroundColor = .cyanColor()
        v.addSubview(textLabel)
        //Set width equal to screen width
        let widthConst = NSLayoutConstraint(item: textLabel, attribute: .Width, relatedBy: .Equal, toItem: v, attribute: .Width, multiplier: 1.0, constant: 0.0)
        v.addConstraint(widthConst)
        //Set height equal to some constant
        let heightConst = NSLayoutConstraint(item: textLabel, attribute: .Height, relatedBy: .Equal, toItem: v, attribute: .Height, multiplier: 0.2, constant: 0.0)
        v.addConstraint(heightConst)
        //Position the label right below top of the screen
        let verticalConst = NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-[textLabel]", options: nil, metrics: nil, views: ["topLayoutGuide": vc.topLayoutGuide, "textLabel": textLabel])
        v.addConstraints(verticalConst)
        return textLabel
    }
    
    //This will instantiate our grid of buttons
    func setupButtons(v: UIView, vc: CalculatorViewController, numberLabel: UILabel) {
        
        //Get the number of rows and columns in our grid of buttons
        let rows = buttonGrid.count
        let cols = buttonGrid[0].count
        
        //Iterate through each button on the grid and create it
        var viewsDictionary = [String: AnyObject]()
        viewsDictionary["numberLabel"] = numberLabel
        viewsDictionary["blg"] = vc.bottomLayoutGuide
        for row in 0...(rows-1) {
            for col in 0...(cols-1) {
                let button = UIButton()
                button.setTitle(buttonGrid[row][col], forState: .Normal)
                button.setTranslatesAutoresizingMaskIntoConstraints(false)
                button.backgroundColor = .lightGrayColor()
                button.setTitleColor(UIColor.blackColor(), forState: .Normal)
                v.addSubview(button)
                let viewName = "button\(row+1)x\(col+1)"
                viewsDictionary[viewName] = button
            }
        }
        
        //Create the clear button
        let button = UIButton()
        button.setTitle("Clear", forState: .Normal)
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.backgroundColor = .lightGrayColor()
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        v.addSubview(button)
        viewsDictionary["clearButton"] = button
        let clearButtonHorizontalConst = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[clearButton]-|", options: nil, metrics: nil, views: viewsDictionary)
        v.addConstraints(clearButtonHorizontalConst)
        
        //Build the horizontal constraints
        for row in 1...(rows) {
            let firstButton = "button\(row)x1"
            var vfl = "H:|-[\(firstButton)(>=1,<=300)]"
            for col in 2...(cols) {
                let button = "button\(row)x\(col)"
                vfl += "-[\(button)(==\(firstButton))]"
            }
            vfl += "-|"
            let horizontalConst = NSLayoutConstraint.constraintsWithVisualFormat(vfl, options: nil, metrics: nil, views: viewsDictionary)
            v.addConstraints(horizontalConst)
        }
        
        //Build the vertical constraints
        for col in 1...(cols) {
            let firstButton = "button1x\(col)"
            var vfl = "V:[numberLabel]-[clearButton(==\(firstButton))]-[\(firstButton)(>=1,<=300)]"
            for row in 2...(rows) {
                let button = "button\(row)x\(col)"
                vfl += "-[\(button)(==\(firstButton))]"
            }
            vfl += "-[blg]"
            let verticalConst = NSLayoutConstraint.constraintsWithVisualFormat(vfl, options: nil, metrics: nil, views: viewsDictionary)
            v.addConstraints(verticalConst)
        }
    }
}














