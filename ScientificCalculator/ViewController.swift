//
//  ViewController.swift
//  ScientificCalculator
//
//  Created by Alberto Benavides on 2/7/15.
//  Copyright (c) 2015 rocket-raccoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Set out the elements of the view
        var numberLabel = CalculatorView().setupNumberLabel(view, vc: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

