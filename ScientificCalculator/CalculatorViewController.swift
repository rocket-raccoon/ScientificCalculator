//
//  CalculatorViewController.swift
//  ScientificCalculator
//
//  Created by Alberto Benavides on 2/7/15.
//  Copyright (c) 2015 rocket-raccoon. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Create the calculator view on screen
        var numberLabel = CalculatorView().setupNumberLabel(view, vc: self)
        CalculatorView().setupButtons(view, vc: self, numberLabel: numberLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

