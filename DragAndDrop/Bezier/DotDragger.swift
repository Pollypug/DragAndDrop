//
//  BezierDraw.swift
//  DragAndDrop
//
//  Created by Polina on 7/19/18.
//  Copyright © 2018 Polina. All rights reserved.
//

import UIKit

class DotDragger: UIView {
    
    private let dotRadius: CGFloat = 6.0
    private let dotCenter = CGPoint(x: 10.0, y: 10.0)
    private var frameAndSize: CGRect
    
    override init(frame: CGRect) {
        self.frameAndSize = frame
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        createDot()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Dot
    
    private func createDot() {
        
        let path = UIBezierPath()
        
        path.addArc(withCenter: dotCenter, radius: dotRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        path.close()
        
        UIColor.blue.setFill()
        path.fill()
    }
    
 
  
}
