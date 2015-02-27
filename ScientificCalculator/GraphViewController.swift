//
//  GraphViewController.swift
//  ScientificCalculator
//
//  Created by Alberto Benavides on 2/24/15.
//  Copyright (c) 2015 rocket-raccoon. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()
        
        //Set the graph view up
        let graphView = GraphView(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height))
        graphView.backgroundColor = .whiteColor()
        graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView, action: "zoom:"))
        graphView.addGestureRecognizer(UIPanGestureRecognizer(target: graphView, action: "pan:"))
        view.addSubview(graphView)
        
        //AxesDrawer().drawAxesInRect(view.bounds, origin: view.center, pointsPerUnit: 1.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
