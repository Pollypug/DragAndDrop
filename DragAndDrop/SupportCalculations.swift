//
//  SupportCalculations.swift
//  DragAndDrop
//
//  Created by Polina on 7/19/18.
//  Copyright © 2018 Polina. All rights reserved.
//

import Foundation
import UIKit

class SupportCalculations {

    static func middlePointCalculation(firstPoint: CGPoint, lastPoint: CGPoint) -> CGPoint {
        
        var middleSegmentPoint = CGPoint(x: 0.0, y: 0.0)
        
        middleSegmentPoint.x = (firstPoint.x + lastPoint.x) / 2
        middleSegmentPoint.y = (firstPoint.y + lastPoint.y) / 2
        
        return middleSegmentPoint
    }
    
    static func changeQuadsCoordinates() {
        for index in 0..<Points.shared.dotCoordinates.count {
            
            if Points.shared.dotCoordinates[index] == Points.shared.dotCoordinates.last {
                Points.shared.quadsCoordinates[index] = middlePointCalculation(firstPoint: Points.shared.dotCoordinates.last!, lastPoint: Points.shared.dotCoordinates.first!)
            } else {
                Points.shared.quadsCoordinates[index] = middlePointCalculation(firstPoint: Points.shared.dotCoordinates[index], lastPoint: Points.shared.dotCoordinates[index + 1])
            }
        }
    }
}
