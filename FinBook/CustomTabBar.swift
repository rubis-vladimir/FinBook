//
//  CustomTabBar.swift
//  FinBook
//
//  Created by Владимир Рубис on 12.07.2021.
//

import UIKit

class CustomTabBar: UITabBar {
    
    // MARK: - Customization TabBar
    
    private var tabBarWidth: CGFloat { self.bounds.width }
    private var tabBarHeight: CGFloat { self.bounds.height }
    private var centerWidth: CGFloat { self.bounds.width / 2 }
    private var circleRadius: CGFloat { self.bounds.height * 0.5 }
    
    private var shapeLayer: CALayer?
    
    // MARK: Outline TabBar
    
    private func shapePath() -> CGPath {
        let path = UIBezierPath()
        let height: CGFloat = 35.0
        let centerWidth = self.frame.width / 2
        
        path.move(to: CGPoint(x: 15, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // the beginning of the trough

        // first curve down
        path.addCurve(to: CGPoint(x: centerWidth, y: height),
                      controlPoint1: CGPoint(x: (centerWidth - 22), y: 0), controlPoint2: CGPoint(x: centerWidth - 37, y: height))
        // second curve up
        path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 37, y: height), controlPoint2: CGPoint(x: (centerWidth + 22), y: 0))

        // complete the rect
        path.addLine(to: CGPoint(x: self.frame.width - 15, y: 0))
        path.addArc(withCenter: CGPoint(x: self.frame.width - 15, y: 15),
                            radius: 15,
                            startAngle:  3 * .pi / 2,
                            endAngle:  0,
                            clockwise: true)
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: 15))
        path.addArc(withCenter: CGPoint(x: 15, y: 15),
                            radius: 15,
                            startAngle: .pi,
                            endAngle:  3 * .pi / 2,
                            clockwise: true)
        path.close()
        
        return path.cgPath
    }
    
    private func drawTabBar() {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shapePath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor(red: 155/255, green: 160/255, blue: 163/255, alpha: 1).cgColor
        shapeLayer.lineWidth = 3.0
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer    }
    
    override func draw(_ rect: CGRect) {
        drawTabBar()
    }
    
    // MARK: Override button touch
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let buttonRadius: CGFloat = circleRadius
        return abs(self.center.x - point.x) > buttonRadius || abs(point.y) > buttonRadius
    }
}
