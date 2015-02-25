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
    let buttonGrid =   [["7", "8", "9", "✖️", "√", "C"],
                        ["4", "5", "6", "➕", "sin", "M"],
                        ["1", "2", "3", "➖", "cos", "->M"],
                        ["0", ".", "⏎", "➗", "pi", "Plot"]]
    
    //Creates the label at the top of the screen that holds all the numbers for the calculator
    func setupTextLabels(v: UIView, vc: CalculatorViewController) -> (UILabel, UILabel) {
        //Instantiate the history text label
        var historyLabel = UILabel()
        historyLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        historyLabel.font = UIFont(name: historyLabel.font.fontName, size: 16.0)
        historyLabel.text = ""
        historyLabel.textAlignment = .Right
        historyLabel.layer.borderWidth = 1.0
        historyLabel.backgroundColor = .yellowColor()
        v.addSubview(historyLabel)
        //Instantiate the text label
        var textLabel = UILabel(frame: CGRect())
        textLabel.text = "0"
        textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        textLabel.font = UIFont(name: textLabel.font.fontName, size: 32.0)
        textLabel.textAlignment = .Right
        textLabel.layer.borderWidth = 1.0
        textLabel.backgroundColor = .cyanColor()
        v.addSubview(textLabel)
        //Set width equal to screen width
        let widthConst1 = NSLayoutConstraint(item: textLabel, attribute: .Width, relatedBy: .Equal, toItem: v, attribute: .Width, multiplier: 1.0, constant: 0.0)
        let widthConst2 = NSLayoutConstraint(item: historyLabel, attribute: .Width, relatedBy: .Equal, toItem: v, attribute: .Width, multiplier: 1.0, constant: 0.0)
        v.addConstraint(widthConst1)
        v.addConstraint(widthConst2)
        //Set height equal to some constant
        let heightConst1 = NSLayoutConstraint(item: textLabel, attribute: .Height, relatedBy: .Equal, toItem: v, attribute: .Height, multiplier: 0.15, constant: 0.0)
        let heightConst2 = NSLayoutConstraint(item: historyLabel, attribute: .Height, relatedBy: .Equal, toItem: v, attribute: .Height, multiplier: 0.05, constant: 0.0)
        v.addConstraint(heightConst1)
        v.addConstraint(heightConst2)
        //Position the label right below top of the screen
        let viewsDictionary = ["topLayoutGuide": vc.topLayoutGuide, "textLabel": textLabel, "historyLabel": historyLabel]
        let verticalConst = NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-[historyLabel]-[textLabel]", options: nil, metrics: nil, views: viewsDictionary)
        v.addConstraints(verticalConst)
        return (textLabel, historyLabel)
    }
    
    //This will instantiate our grid of buttons
    func setupButtons(v: UIView, vc: CalculatorViewController, numberLabel: UILabel, historyLabel: UILabel) {
        
        //Get the number of rows and columns in our grid of buttons
        let rows = buttonGrid.count
        let cols = buttonGrid[0].count
        
        //Iterate through each button on the grid and create it
        var viewsDictionary = [String: AnyObject]()
        viewsDictionary["tlg"] = vc.topLayoutGuide
        viewsDictionary["numberLabel"] = numberLabel
        viewsDictionary["historyLabel"] = historyLabel
        viewsDictionary["blg"] = vc.bottomLayoutGuide
        for row in 0...(rows-1) {
            for col in 0...(cols-1) {
                let button = UIButton()
                button.setTitle(buttonGrid[row][col], forState: .Normal)
                button.setTranslatesAutoresizingMaskIntoConstraints(false)
                button.backgroundColor = .lightGrayColor()
                button.setTitleColor(UIColor.blackColor(), forState: .Normal)
                button.addTarget(vc, action: "press:", forControlEvents: .TouchUpInside)
                v.addSubview(button)
                let viewName = "button\(row+1)x\(col+1)"
                viewsDictionary[viewName] = button
            }
        }
        
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
            var vfl = "V:[tlg]-[historyLabel]-[numberLabel]-[\(firstButton)(>=1,<=300)]"
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














