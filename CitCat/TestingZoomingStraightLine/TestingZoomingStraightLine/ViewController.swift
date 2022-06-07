//
//  ViewController.swift
//  TestingZoomingStraightLine
//
//  Created by Kyle Chung on 6/3/22.
//  Copyright © 2022 Kyle Chung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    
    
    @IBOutlet var gridView: GridView!
    @IBOutlet var tempImageView: UIImageView!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var umbrellaView: UmbrellaView!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("viewDidLoad")
        scrollView.delegate = self
        scrollView.isScrollEnabled = false
        umbrellaView.noDraw = false
        gridView.gridWidth = gridView.bounds.width / 10
        gridView.gridHeight = gridView.bounds.height / 10
    }
    
    @IBAction func scrollSwitch(_ sender: Any) {
        scrollView.isScrollEnabled = !scrollView.isScrollEnabled
        umbrellaView.noDraw = !umbrellaView.noDraw //<-this seems bad (lots of cross referencing)
        print("Scroll Mode: \(scrollView.isScrollEnabled)")
    }
  
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return umbrellaView
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        print(scale)
        gridView.gridWidth *= scale
        gridView.gridHeight *= scale
        gridView.draw(umbrellaView.frame)
    }
}

