//
//  UmbrellaScrollView.swift
//  CitCat
//
//  Created by bingchilling1 on 6/1/22.
//

import UIKit

class UmbrellaView: UIView {
    
    @IBOutlet var gridView: GridView!
    @IBOutlet var tempImageView: UIImageView!
    @IBOutlet var mainImageView: UIImageView!
    
    var lines = [[CGPoint]]()
    var currLine = [CGPoint]()
    
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
            lastPoint = CGPoint(x: round(round(lastPoint.x / gridView.gridWidth) * gridView.gridWidth), y: round(round(lastPoint.y / gridView.gridHeight) * gridView.gridHeight))
        }
        currLine.append(lastPoint)
        
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return  }
        
        
        let currentPoint = touch.location(in: tempImageView)
        
        var actualPoint = currentPoint
        
        if grid {
            actualPoint = CGPoint(x: round(round(actualPoint.x / gridView.gridWidth) * gridView.gridWidth), y: round(round(actualPoint.y / gridView.gridHeight) * gridView.gridHeight))
            if lastPoint == actualPoint { return }
            print(actualPoint.y - lastPoint.y)
            if abs(actualPoint.x - lastPoint.x) > gridView.gridWidth || abs(actualPoint.y - lastPoint.y) > gridView.gridHeight || (abs(actualPoint.x - lastPoint.x) == gridView.gridWidth && abs(actualPoint.y - lastPoint.y) == gridView.gridHeight) {
                var w = abs(actualPoint.x - lastPoint.x) / gridView.gridWidth
                var h = abs(actualPoint.y - lastPoint.y) / gridView.gridHeight
                while w > 0 || h > 0 {
                    while w > 0 {
                        let q = CGPoint(x: lastPoint.x + (actualPoint.x - lastPoint.x) / w, y: lastPoint.y)
                        currLine.append(q)
                        drawLine(from: lastPoint, to: q)
                        lastPoint = q
                        w -= 1
                    }
                    while h > 0 {
                        let q = CGPoint(x: lastPoint.x, y: lastPoint.y + (actualPoint.y - lastPoint.y) / h)
                        currLine.append(q)
                        drawLine(from: lastPoint, to: q)
                        lastPoint = q
                        h -= 1
                    }
                }
            } else {
                currLine.append(actualPoint)
                drawLine(from: lastPoint, to: actualPoint)
                lastPoint = actualPoint
            }
        } else if straight {
            tempImageView.image = nil
            drawLine(from: lastPoint, to: actualPoint)
        } else {
            currLine.append(actualPoint)
            drawLine(from: lastPoint, to: actualPoint)
            lastPoint = actualPoint
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        lines.append(currLine)
        currLine = [CGPoint]()
        
        
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: self.bounds, blendMode: .normal, alpha: 1)
        tempImageView.image?.draw(in: self.bounds, blendMode: .normal, alpha: opacity)
        
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        tempImageView.image = nil
        
    }

    @IBAction func resetPressed(_ sender: Any) {
        lines = [[CGPoint]]()
        currLine = [CGPoint]()
        mainImageView.image = nil
    }
    
    @IBAction func undoPressed(_ sender: Any) {
        if lines.isEmpty { return }
        lines.removeLast()
        mainImageView.image = nil
        
        for line in lines {
            for i in line.indices.dropLast() {
                drawLine(from: line[i], to: line[i+1])
            }
        }
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
        
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        
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

