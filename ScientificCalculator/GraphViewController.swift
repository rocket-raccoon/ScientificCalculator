//
//  GraphViewController.swift
//  ScientificCalculator
//
//  Created by Alberto Benavides on 2/24/15.
//  Copyright (c) 2015 rocket-raccoon. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController, GraphViewDataSource {
    
    var program: AnyObject?
    var calculatorModel: CalculatorModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()
        
        //Set the graph view up
        let graphView = GraphView(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height))
        graphView.dataSource = self
        graphView.backgroundColor = .whiteColor()
        graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView, action: "zoom:"))
        graphView.addGestureRecognizer(UIPanGestureRecognizer(target: graphView, action: "pan:"))
        let tapGestureRecognizer = UITapGestureRecognizer(target: graphView, action: "resetFocus:")
        tapGestureRecognizer.numberOfTapsRequired = 2
        graphView.addGestureRecognizer(tapGestureRecognizer)
        view.addSubview(graphView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getData(x_coords: [CGFloat]) -> [CGFloat]? {
        if program != nil {
            
            //First, temporarily save the current program and saved variable for M while we calculate data values
            let oldProgram = calculatorModel.program as Array<String>
            let oldM = calculatorModel.variableValues["M"]
            
            //Now, calculate the function values for the given x values
            calculatorModel.program = program!
            var y_coords = [CGFloat]()
            for x in x_coords {
                calculatorModel.variableValues["M"] = Double(x)
                if let y = calculatorModel.calculate() {
                    y_coords.append(CGFloat(y))
                }
            }
            
            //Replace the program and M values again
            calculatorModel.program = oldProgram
            calculatorModel.variableValues["M"] = oldM
            return y_coords
        }
        return nil
    }
    
}



