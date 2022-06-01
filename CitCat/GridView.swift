//
//  GridView.swift
//  CitCat
//
//  Created by bingchilling1 on 6/1/22.
//

import UIKit

class GridView: UIView {
    var gridWidth = 128
    var gridHeight = 128
    var lineWidth: CGFloat = 1.0
    var lineColor: CGColor = UIColor.gray.cgColor
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {

            context.setLineWidth(lineWidth)
            context.setStrokeColor(lineColor)

            let numberOfColumns = Int(rect.width) / Int(gridWidth)
            for i in 1...numberOfColumns {
                var startPoint = CGPoint.zero
                var endPoint = CGPoint.zero
                startPoint.x = CGFloat(gridWidth * i)
                startPoint.y = 0.0
                endPoint.x = startPoint.x
                endPoint.y = frame.size.height
                context.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
                context.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
                context.strokePath()
            }
            let numberOfRows = Int(rect.height) / Int(gridHeight)
            for j in 1...numberOfRows {
                var startPoint = CGPoint.zero
                var endPoint = CGPoint.zero
                startPoint.x = 0.0
                startPoint.y = CGFloat(gridHeight * j)
                endPoint.x = frame.size.width
                endPoint.y = startPoint.y
                context.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
                context.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
                context.strokePath()
            }
        }
    }
}
