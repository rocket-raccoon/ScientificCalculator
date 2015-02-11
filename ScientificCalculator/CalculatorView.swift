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
    let buttonGrid =   [["1", "2", "3"],
                        ["4", "5", "6"],
                        ["7", "8", "9"],
                        ["", "0,", "🆗"]]
    
    //Creates the label at the top of the screen that holds all the numbers for the calculator
    func setupNumberLabel(v: UIView, vc: ViewController) -> UILabel {
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
        let heightConst = NSLayoutConstraint(item: textLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0.0, constant: 30.0)
        v.addConstraint(widthConst)
        //Position the label right below top of the screen
        let verticalConst = NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-[textLabel]", options: nil, metrics: nil, views: ["topLayoutGuide": vc.topLayoutGuide, "textLabel": textLabel])
        v.addConstraints(verticalConst)
        return textLabel
    }
    
    //This will instantiate our grid of buttons
    func setupButtons() {
        //Get the number of rows and columns in our grid of buttons
        let rows = buttonGrid.count
        let cols = buttonGrid[0].count
        //Iterate through each button on the grid and create it
        /*for row in 0...0 {
            for col in 0..cols-1 {
                let button = UIButton(frame: CGRect())
                button.setTitle(buttonGrid[row][col], forState: .TouchUpInside)
                
            }
        }*/
    }
    
}














