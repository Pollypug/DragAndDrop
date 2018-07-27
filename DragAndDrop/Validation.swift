//
//  Validation.swift
//  DragAndDrop
//
//  Created by Polina on 7/25/18.
//  Copyright © 2018 Polina. All rights reserved.
//

import Foundation
import UIKit

class Validation {
    
    //    (y-y1)*(x2-x1)-(x-x1)*(y2-y1)

    func convex(point: CGPoint) -> Bool {
        
        var convexValue: CGFloat = 1.0
        
        if point == Points.shared.dotCoordinates.last {
            for dot in Points.shared.dotCoordinates {
                let lineValue = lineEquation(firstPoint: point, secondPoint: Points.shared.dotCoordinates.first!, checkPoint: dot)
                if lineValue != 0 {
                    convexValue *= lineValue
                }
            }
        } else {
            let indexOfSecondPoint = Points.shared.dotCoordinates.index(of: point)! + 1
            for dot in Points.shared.dotCoordinates {
                
                let lineValue = lineEquation(firstPoint: point, secondPoint: Points.shared.dotCoordinates[indexOfSecondPoint],
                                             checkPoint: dot)
                if lineValue != 0 {
                    convexValue *= lineValue
                }
            }
        }
        
        let horizontalOppositeLineIntesection = intersectionPointFinder(firstLineStart: 0, firstLineEnd: 1, secondLineStart: 3, secondLineEnd: 2)
        
        let vetricalOppositeLineIntesection = intersectionPointFinder(firstLineStart: 1, firstLineEnd: 2, secondLineStart: 0, secondLineEnd: 3)
        
        let checkState = horizontalOppositeLineIntesection.x > 0 && horizontalOppositeLineIntesection.y > 0 && vetricalOppositeLineIntesection.x > 0 && vetricalOppositeLineIntesection.y > 0
        
        return convexValue >= 0 && !checkState
    }
    
    private func lineEquation(firstPoint: CGPoint, secondPoint: CGPoint, checkPoint: CGPoint) -> CGFloat {
        
        let result =  (checkPoint.x - firstPoint.x) * (secondPoint.y - firstPoint.y) - (checkPoint.y - firstPoint.y) * (secondPoint.x - firstPoint.x)
        
        return result
    }
    
    func intersectionPointFinder(firstLineStart: Int, firstLineEnd: Int, secondLineStart: Int, secondLineEnd: Int) -> CGPoint {
        
        let x1Center = Points.shared.dotCoordinates[firstLineEnd].x - Points.shared.dotCoordinates[firstLineStart].x
        let y1Center = Points.shared.dotCoordinates[firstLineEnd].y - Points.shared.dotCoordinates[firstLineStart].y
        let x2Center = Points.shared.dotCoordinates[secondLineEnd].x - Points.shared.dotCoordinates[secondLineStart].x
        let y2Center = Points.shared.dotCoordinates[secondLineEnd].y - Points.shared.dotCoordinates[secondLineStart].y
        
        var x = y1Center * x2Center - y2Center * x1Center
        
        var y = Points.shared.dotCoordinates[secondLineStart].x * Points.shared.dotCoordinates[secondLineEnd].y - Points.shared.dotCoordinates[secondLineStart].y * Points.shared.dotCoordinates[secondLineEnd].x
        
        x = ((Points.shared.dotCoordinates[firstLineStart].x * Points.shared.dotCoordinates[firstLineEnd].y - Points.shared.dotCoordinates[firstLineStart].y * Points.shared.dotCoordinates[firstLineEnd].x) * x2Center - y * x1Center) / x
        
        y = (y2Center * x - y) / x2Center
        
        return CGPoint(x: x, y: y)
    }
}
