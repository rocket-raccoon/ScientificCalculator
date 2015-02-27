//
//  GraphView.swift
//  ScientificCalculator
//
//  Created by Alberto Benavides on 2/25/15.
//  Copyright (c) 2015 rocket-raccoon. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    var scale: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        AxesDrawer().drawAxesInRect(self.bounds, origin: self.center, pointsPerUnit: scale)
        
    }
    
    func zoom(gr: UIPinchGestureRecognizer) {
        if gr.state == .Changed {
            scale *= gr.scale
            gr.scale = 1.0
        }
        println("zoom is working")
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
