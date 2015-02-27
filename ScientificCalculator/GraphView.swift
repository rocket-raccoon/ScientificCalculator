//
//  GraphView.swift
//  ScientificCalculator
//
//  Created by Alberto Benavides on 2/25/15.
//  Copyright (c) 2015 rocket-raccoon. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    var scale: CGFloat = 1.0 { didSet { setNeedsDisplay() } }
    lazy var origin: CGPoint =  self.center
    
    override func drawRect(rect: CGRect) {
        AxesDrawer().drawAxesInRect(self.bounds, origin: origin, pointsPerUnit: scale)
    }
    
    func pan(gr: UIPanGestureRecognizer) {
        if gr.state == UIGestureRecognizerState.Changed {
            let newFocalPoint = gr.translationInView(self)
            origin.x += newFocalPoint.x
            origin.y += newFocalPoint.y
            setNeedsDisplay()
            gr.setTranslation(CGPoint(x: 0, y: 0), inView: self)
        }
        println("pan is working")
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
