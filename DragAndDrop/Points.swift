//
//  Points.swift
//  DragAndDrop
//
//  Created by Polina on 7/23/18.
//  Copyright © 2018 Polina. All rights reserved.
//

import Foundation
import  UIKit

class Points {
    
    private let startPoint: CGFloat = 50.0
    var dotCoordinates =  [CGPoint]()
    var quadsCoordinates =  [CGPoint]()
    
    var size: CGSize = CGSize() {
        didSet {
            size.width -= startPoint / 2
            size.height -= startPoint  
            setupDotLayoutData()
            setupQuadLayaoutData()
        }
    }

    static let shared = Points()

    private init() {
    }
    
    private func setupDotLayoutData() {
        
        dotCoordinates = [CGPoint(x: self.startPoint, y: self.startPoint),
                           CGPoint(x: self.size.width, y: self.startPoint),
                           CGPoint(x: self.size.width, y: self.size.height),
                           CGPoint(x: self.startPoint, y: self.size.height)]
        
        for index in 0..<dotCoordinates.count {
            
            if dotCoordinates[index] == dotCoordinates.last {
                quadsCoordinates.append(SupportCalculations.middlePointCalculation(firstPoint: dotCoordinates.last!, lastPoint: dotCoordinates.first!))
            } else {
                quadsCoordinates.append(SupportCalculations.middlePointCalculation(firstPoint: dotCoordinates[index], lastPoint: dotCoordinates[index + 1]))
            }
        }
    }
    
    func setupQuadLayaoutData() {
        quadsCoordinates.removeAll()
        for index in 0..<dotCoordinates.count {
            
            if dotCoordinates[index] == dotCoordinates.last {
                quadsCoordinates.append(SupportCalculations.middlePointCalculation(firstPoint: dotCoordinates.last!, lastPoint: dotCoordinates.first!))
            } else {
                quadsCoordinates.append(SupportCalculations.middlePointCalculation(firstPoint: dotCoordinates[index], lastPoint: dotCoordinates[index + 1]))
            }
        }
    }
}
