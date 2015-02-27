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
    var origin: CGPoint? { didSet { setNeedsDisplay() }}
    var color = UIColor.blackColor()
    
    override func drawRect(rect: CGRect) {
        //If the origin's never been set or modified before, make it the center of the view
        if origin == nil {
            origin = self.center
        }
        println(scale)
        AxesDrawer().drawAxesInRect(self.bounds, origin: origin!, pointsPerUnit: scale)
        plotFunction()
    }
    
    //Given a x-coord in pixel coordinates, returns the point in the graphs coordinate system
    func convertFromPixelToScale(x: CGFloat) -> CGFloat {
        let graphX = (x - origin!.x) / scale
        let graphY = 0.5*(pow(graphX,2))
        let pixelY = (-graphY * scale) + origin!.y
        return pixelY
    }
    
    //Draws the specified function on the graph view
    func plotFunction() {
        color.set()
        let path = UIBezierPath()
        var currentX: CGFloat = bounds.minX
        var currentY = convertFromPixelToScale(currentX)
        path.moveToPoint(CGPoint(x: currentX, y: currentY))
        while currentX <= bounds.maxX {
            currentX += CGFloat(1.0)
            currentY = convertFromPixelToScale(currentX)
            path.addLineToPoint(CGPoint(x: currentX, y: currentY))
        }
        path.lineWidth = 1.0
        path.stroke()
    }
    
    //When a user drags across the screen, we will move the focus to that area of the graph
    func pan(gr: UIPanGestureRecognizer) {
        if gr.state == UIGestureRecognizerState.Changed {
            let newFocalPoint = gr.translationInView(self)
            origin?.x += newFocalPoint.x
            origin?.y += newFocalPoint.y
            gr.setTranslation(CGPoint(x: 0, y: 0), inView: self)
        }
    }
    
    //When the user pinches, we will zoom in or out on the screen
    func zoom(gr: UIPinchGestureRecognizer) {
        if gr.state == .Changed {
            scale *= gr.scale
            gr.scale = 1.0
        }
    }
    
    //When the user double taps the screen, we want to reset the focus of the graph to the center
    func resetFocus(gr: UITapGestureRecognizer) {
        origin = self.center
    }
    
}
