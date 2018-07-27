//
//  QuadDragger.swift
//  DragAndDrop
//
//  Created by Polina on 7/27/18.
//  Copyright © 2018 Polina. All rights reserved.
//

import UIKit

class QuadDragger: UIView {

    private var frameAndSize: CGRect
    
    override init(frame: CGRect) {
        self.frameAndSize = frame
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        createRectangle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createRectangle() {
        
        let path = UIBezierPath(roundedRect: frameAndSize, cornerRadius: 10.0)
        path.close()
        
        UIColor.blue.setFill()
        path.fill()
    }

}
