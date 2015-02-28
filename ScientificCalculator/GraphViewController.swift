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
    var graphView: GraphView!
    var equationText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()
        
        //Set the graph view up
        println("aa")
        println(view.bounds.width)
        graphView = GraphView(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height))
        graphView.dataSource = self
        graphView.backgroundColor = .whiteColor()
        graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView, action: "zoom:"))
        graphView.addGestureRecognizer(UIPanGestureRecognizer(target: graphView, action: "pan:"))
        let tapGestureRecognizer = UITapGestureRecognizer(target: graphView, action: "resetFocus:")
        tapGestureRecognizer.numberOfTapsRequired = 2
        graphView.addGestureRecognizer(tapGestureRecognizer)
        view.addSubview(graphView)
        
        //Set the equation text label up
        createEquationTextLabel()
    }
    
    //When the screen rotates, we want to reset the frame and center for the new orientation
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        graphView.frame = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
        graphView.origin = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createEquationTextLabel() {
        //Instantiate the text label
        var textLabel = UILabel()
        textLabel.text = equationText
        textLabel.sizeToFit()
        textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(textLabel)
        //Set the vertical constraint
        let vertConst = NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-[textLabel]", options: nil, metrics: nil, views: ["textLabel": textLabel, "topLayoutGuide": topLayoutGuide])
        view.addConstraints(vertConst)
        //Set the horizontal constraint
        let horizConst = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[textLabel]", options: nil, metrics: nil, views: ["textLabel": textLabel])
        view.addConstraints(horizConst)
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
            return y_coords.count != 0 ? y_coords : nil
        }
        return nil
    }
    
}



