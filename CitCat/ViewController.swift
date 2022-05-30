//
//  ViewController.swift
//  CitCat
//
//  Created by Larry Du on 3/17/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var tempImageView: UIImageView!
    @IBOutlet var mainImageView: UIImageView!
    
    var lastPoint: CGPoint = CGPoint.zero
    var color: UIColor = UIColor.black
    var brushWidth: CGFloat = 3.0
    var opacity: CGFloat = 1.0
    var straight: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return  }
        lastPoint = touch.location(in: view)
        
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return  }
        
        
        let currentPoint = touch.location(in: view)
        
        if straight {
       tempImageView.image = nil
        drawLine(from: lastPoint, to: currentPoint)
        } else {
            drawLine(from: lastPoint, to: currentPoint)
            lastPoint = currentPoint
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        UIGraphicsBeginImageContext(view.frame.size)
        mainImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1)
        tempImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: opacity)
        
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
    
    
    
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContext(view.frame.size)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        tempImageView.image?.draw(in: view.bounds)
        
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
