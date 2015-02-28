//
//  GraphView.swift
//  ScientificCalculator
//
//  Created by Alberto Benavides on 2/25/15.
//  Copyright (c) 2015 rocket-raccoon. All rights reserved.
//

import UIKit

protocol GraphViewDataSource: class {
    func getData(x: [CGFloat]) -> [CGFloat?]?
}

class GraphView: UIView {
    
    weak var dataSource: GraphViewDataSource?
    
    var scale: CGFloat = 20.0 { didSet { setNeedsDisplay() } }
    var origin: CGPoint? { didSet { setNeedsDisplay() }}
    var color = UIColor.blackColor()
    
    //Wrapper function that draws the axis as well as the function on screen
    override func drawRect(rect: CGRect) {
        //If the origin's never been set or modified before, make it the center of the view
        println("xxs")
        println(origin)
        if origin == nil {
            origin = self.center
        }
        println(origin)
        AxesDrawer().drawAxesInRect(self.bounds, origin: origin!, pointsPerUnit: scale)
        plotFunction()
    }
    
    func convertPixelToGraph(x: CGFloat) -> CGFloat {
        return (x-origin!.x) / scale
    }
    
    func convertGraphToPixel(y: CGFloat) -> CGFloat {
        return (-y * scale) + origin!.y
    }
    
    //Checks to see whether the given cgfloat optional is a discontinuity or not
    func isDiscontinuity(number: CGFloat?) -> Bool {
        if let actualNumber = number {
            return (!actualNumber.isNormal && !actualNumber.isZero)
        } else {
            return true
        }
    }
    
    //Draws the specified function on the graph view
    func plotFunction() {
        
        //Set a boolean to track if the graph is being drawn
        var isDrawing = false
        
        //Get all the x values in pixel coordinates
        var pixelX = [CGFloat]()
        for var x = bounds.minX; x <= bounds.maxX; x++ {
            pixelX.append(x)
        }
        
        //Transform the pixel x values into graph coordinates
        var graphX = pixelX.map { self.convertPixelToGraph($0) }
        
        //Pass the x graph coordinates to the data source delegate and return the y graph coordinates
        if let graphY = dataSource?.getData(graphX) {
            color.set()
            let path = UIBezierPath()
            for i in 0..<graphY.count {
                if !isDiscontinuity(graphY[i]) {
                    let curPixelX = pixelX[i]
                    let curPixelY = convertGraphToPixel(graphY[i]!)
                    if isDrawing {
                        path.addLineToPoint(CGPoint(x: curPixelX, y: curPixelY))
                    } else {
                        path.moveToPoint(CGPoint(x: curPixelX, y: curPixelY))
                        isDrawing = true
                    }
                } else {
                    isDrawing = false
                }
            }
            path.lineWidth = 5.0
            path.stroke()
        }
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
