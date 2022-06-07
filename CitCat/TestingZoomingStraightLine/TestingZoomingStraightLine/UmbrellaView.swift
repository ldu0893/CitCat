//
//  UmbrellaView.swift
//  TestingZoomingStraightLine
//
//  Created by Kyle Chung on 6/6/22.
//  Copyright © 2022 Kyle Chung. All rights reserved.
//

import UIKit

class UmbrellaView: UIView {

    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet var gridView: GridView!
    @IBOutlet var tempImageView: UIImageView!
    @IBOutlet var mainImageView: UIImageView!
    
    var lastPoint: CGPoint = CGPoint.zero
    var color: UIColor = UIColor.black
    var brushWidth: CGFloat = 3.0
    var opacity: CGFloat = 1.0
    var straight: Bool = true
    
    var grid: Bool = false
    
    var noDraw: Bool = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("touchesBegan")
        guard let touch = touches.first else { return  }
        lastPoint = touch.location(in: self)
        if grid {
            lastPoint = CGPoint(x: round(lastPoint.x / gridView.gridWidth) * gridView.gridWidth, y: round(lastPoint.y / gridView.gridHeight) * gridView.gridHeight)
        }
        
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return  }
        
        
        let currentPoint = touch.location(in: tempImageView)
        
        var actualPoint = currentPoint
        
        if grid {
            actualPoint = CGPoint(x: round(actualPoint.x / gridView.gridWidth) * gridView.gridWidth, y: round(actualPoint.y / gridView.gridHeight) * gridView.gridHeight)
            if lastPoint == actualPoint { return }
            print(actualPoint.y - lastPoint.y)
            drawLine(from: lastPoint, to: actualPoint)
            lastPoint = actualPoint
        } else if straight {
            tempImageView.image = nil
            drawLine(from: lastPoint, to: actualPoint)
        } else {
            drawLine(from: lastPoint, to: actualPoint)
            lastPoint = actualPoint
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        UIGraphicsBeginImageContext(self.frame.size)
        mainImageView.image?.draw(in: self.bounds, blendMode: .normal, alpha: 1)
        tempImageView.image?.draw(in: self.bounds, blendMode: .normal, alpha: opacity)
        
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        tempImageView.image = nil
        
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        
        mainImageView.image = nil
    }
    
    @IBAction func eraserMode(_ sender: Any) {
        
        color = UIColor.white
        brushWidth = 80
    }
    
    @IBAction func switchStroke(_ sender: Any) {
        
        straight = !straight
    }
    
    @IBAction func drawMode(_ sender: Any) {
        
        color = UIColor.black
        brushWidth = 3
        
    }
    
    @IBAction func gridMode(_ sender: Any) {
        
        grid = !grid
        print("grid=\(grid)")
        
    }
    
    
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        
        if noDraw { return }
        
        UIGraphicsBeginImageContext(self.frame.size)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        tempImageView.image?.draw(in: self.bounds)
        
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        context.setLineCap(.square)
        context.setBlendMode(.normal)
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(brushWidth)
        
        context.strokePath()
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
    }
}
