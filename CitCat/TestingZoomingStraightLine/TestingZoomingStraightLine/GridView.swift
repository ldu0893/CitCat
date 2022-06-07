//
//  GridView.swift
//  TestingZoomingStraightLine
//
//  Created by Kyle Chung on 6/6/22.
//  Copyright © 2022 Kyle Chung. All rights reserved.
//

import UIKit

class GridView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var gridWidth: CGFloat = 0.0
    var gridHeight: CGFloat = 0.0
    var lineWidth: CGFloat = 1.0
    var lineColor: CGColor = UIColor.gray.cgColor
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            
            context.setLineWidth(lineWidth)
            context.setStrokeColor(lineColor)
            
            let numberOfColumns: CGFloat = rect.width / gridWidth
            for i in 1...Int(numberOfColumns) {
                var startPoint = CGPoint.zero
                var endPoint = CGPoint.zero
                startPoint.x = CGFloat(gridWidth * CGFloat(i))
                startPoint.y = 0.0
                endPoint.x = startPoint.x
                endPoint.y = frame.size.height
                context.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
                context.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
                context.strokePath()
            }
            let numberOfRows: CGFloat = rect.height / gridHeight
            for j in 1...Int(numberOfRows) {
                var startPoint = CGPoint.zero
                var endPoint = CGPoint.zero
                startPoint.x = 0.0
                startPoint.y = CGFloat(gridHeight * CGFloat(j))
                endPoint.x = frame.size.width
                endPoint.y = startPoint.y
                context.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
                context.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
                context.strokePath()
            }
        }
    }
}
