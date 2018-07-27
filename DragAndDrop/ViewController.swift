//
//  ViewController.swift
//  DragAndDrop
//
//  Created by Polina on 7/19/18.
//  Copyright © 2018 Polina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    lazy var dots = [DotDragger]()
    lazy var quads = [QuadDragger]()
    var quadFrame: QuadDraw!
    var screenOrigin: CGRect!
    lazy var validation = Validation()
    var lastPoint: CGPoint!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        screenOrigin = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        Points.shared.size = screenOrigin.size
        
        createQuad()
        createDots()
        createDraggersQuads()
        
    }
    
    func createDots() {
        
        for point in Points.shared.dotCoordinates {
            let dot = DotDragger(frame: CGRect(x: point.x , y: point.y, width: 20, height: 20))
            dot.backgroundColor = .clear
            
            dots.append(dot)
            view.addSubview(dot)
            dot.center = point
            
            let panGR = UIPanGestureRecognizer(target: self, action: #selector(ViewController.didPan(panGR:)))
            dot.addGestureRecognizer(panGR)
        }
    }
    
    func createQuad() {
        quadFrame = QuadDraw(frame: screenOrigin)
        quadFrame.draw(screenOrigin)
        quadFrame.backgroundColor = UIColor.clear
        view.insertSubview(quadFrame, at: 0)
    }
    
    func createDraggersQuads() {
        
        for point in Points.shared.quadsCoordinates {
            let quad = QuadDragger(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 20))
            quad.backgroundColor = .clear
            
            quads.append(quad)
            view.addSubview(quad)
            quad.center = point
            
            let quadPanGR = UIPanGestureRecognizer(target: self, action: #selector(ViewController.didQuadPan(quadPanGR:)))
            quad.addGestureRecognizer(quadPanGR)
        }
        
    }
    
    // MARK: Dot PanGesture
    
    @objc func didQuadPan(quadPanGR: UIPanGestureRecognizer) {
        
        let point = quadPanGR.location(in: view)
        let draggedView = quadPanGR.view
        let translation = quadPanGR.translation(in: view)
        
        for index in 0..<Points.shared.quadsCoordinates.count {
            
            if draggedView?.center == Points.shared.quadsCoordinates[index] {
                
                if index % 2 == 0 {
                    Points.shared.quadsCoordinates[index].y = point.y
                    Points.shared.dotCoordinates[index].y += translation.y
                    Points.shared.dotCoordinates[index + 1].y += translation.y
                    draggedView?.center = Points.shared.quadsCoordinates[index]
                    } else {
                    if Points.shared.dotCoordinates[index] == Points.shared.dotCoordinates.last! {
                        Points.shared.dotCoordinates[0].x += translation.x
                    } else {
                        Points.shared.dotCoordinates[index + 1].x += translation.x
                    }
                    Points.shared.dotCoordinates[index].x += translation.x
                    Points.shared.quadsCoordinates[index].x = point.x
                    
                    draggedView?.center = Points.shared.quadsCoordinates[index]
                }
                changeDotLocation()
                changeQuadsLocation()
                quadFrame.removeFromSuperview()
                quadFrame = nil
                createQuad()
                quadPanGR.setTranslation(.zero, in: view)
            }
        }
    }
    
    func changeDotLocation() {
        for index in 0..<Points.shared.dotCoordinates.count {
            dots[index].center = Points.shared.dotCoordinates[index]
        }
    }
    
    func changeQuadsLocation() {
        SupportCalculations.changeQuadsCoordinates()
        for index in 0..<Points.shared.quadsCoordinates.count {
            quads[index].center = Points.shared.quadsCoordinates[index]
        }
    }
    
    // MARK: Dot PanGesture
    
    @objc func didPan(panGR: UIPanGestureRecognizer) {
        
        let point = panGR.location(in: view)
        let draggedView = panGR.view
        
        for index in 0..<Points.shared.dotCoordinates.count {
            
            if draggedView?.center == Points.shared.dotCoordinates[index] {
                
                Points.shared.dotCoordinates[index] = point
                
                if validation.convex(point: point){
                    draggedView?.center = point

                } else {
                    draggedView?.center = validation.intersectionPointFinder(firstLineStart: 0, firstLineEnd: 2, secondLineStart: 1, secondLineEnd: 3)
                    Points.shared.dotCoordinates[index] = (draggedView?.center)!
                }
                
                changeQuadsLocation()
                quadFrame.removeFromSuperview()
                quadFrame = nil
                createQuad()
                panGR.setTranslation(.zero, in: view)
            }
        }
        
    }
}

