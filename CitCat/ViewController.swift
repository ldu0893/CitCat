//
//  ViewController.swift
//  CitCat
//
//  Created by Larry Du on 3/17/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        swiped = false
        lastPoint = touch.location(in: view)
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        //init context inside tempImageView
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        tempImageView.image?.draw(in: view.bounds)
        
        //draw line fromPoint -> toPoint
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        context.setLineCap(.round) //set cap to round
        context.setBlendMode(.normal) //set normal blending
        context.setLineWidth(brushWidth) //set width
        context.setStrokeColor(color.cgColor) //set color
        
        context.strokePath() //draw path
        
        //set tempImageView.image to context that was drawn on
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        swiped = true //if dragged, set swiped true
        let currentPoint = touch.location(in: view) //set currentPoint
        drawLine(from: lastPoint, to: currentPoint) //draw short line
        
        lastPoint = currentPoint //update lastPoint
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped { drawLine(from: lastPoint, to: lastPoint) } //draw a single point if no swipe
        
        UIGraphicsBeginImageContext(mainImageView.frame.size) //init context for mainImageView
        //burn tempImageView onto mainImageView, preserving opacity
        mainImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
        tempImageView?.image?.draw(in: view.bounds, blendMode: .normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil //reset tempImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

