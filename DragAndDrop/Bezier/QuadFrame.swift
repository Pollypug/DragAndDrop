//
//  QuadDraw.swift
//  DragAndDrop
//
//  Created by Polina on 7/22/18.
//  Copyright © 2018 Polina. All rights reserved.
//

import UIKit

class QuadDraw: UIView {

    private let lineWidth: CGFloat = 2.0
    private var frameSize: CGSize = CGSize(width: 0.0, height: 0.0)
    private let startPoint: CGFloat = 50.0
    let path = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        createQuad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: Quad
    
     func createQuad() {
        
        path.removeAllPoints()
        
        for dot in Points.shared.dotCoordinates {
            if dot == Points.shared.dotCoordinates.first {
                path.move(to: dot)
            } else {
                path.addLine(to: dot)
            }
        }
        
        path.close()
        path.lineWidth = lineWidth
        UIColor.blue.setStroke()
        path.stroke()
        UIColor.blue.setFill()
        path.fill(with: .normal, alpha: 0.2)
 
    }
 }
