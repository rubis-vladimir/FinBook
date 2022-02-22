//
//  CustomTabBar.swift
//  FinBook
//
//  Created by Владимир Рубис on 12.07.2021.
//

import UIKit

class CustomTabBar: UITabBar {
    
    // MARK: - Propeties
    private var tabBarWidth: CGFloat { self.bounds.width }
    private var tabBarHeight: CGFloat { self.bounds.height + 40 }
    private var centerWidth: CGFloat { self.bounds.width / 2 }

    private var shapeLayer: CALayer?
    
    // MARK: - Override funcs
    override func draw(_ rect: CGRect) {
        tintColor = UIColor.systemMint
        setupTabBarElements()
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let buttonRadius: CGFloat = 30
        
        let pointIsInside = super.point(inside: point, with: event)
        if pointIsInside == true && selectedItem?.tag == 0 {
            for _ in subviews {
                if abs(self.center.x - point.x) < buttonRadius && abs(point.y) < buttonRadius {
                    return false
                }
            }
        }
        return pointIsInside
    }
    
    // MARK: - Customization TabBar
    private func setupTabBarElements() {
        let offsetItem = bounds.width / 15
        let horizontalPositionItems: [CGFloat] = [0, -offsetItem , offsetItem , 0]
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shapePath()
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.fillColor = UIColor.systemGray5.cgColor
        shapeLayer.lineWidth = 1.5
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        for (item, offset) in zip(items!, horizontalPositionItems) {
            item.titlePositionAdjustment.horizontal = selectedItem?.tag == 0 ? offset : 0
        }
        self.shapeLayer = shapeLayer
    }
    
    private func shapePath() -> CGPath {
        let height: CGFloat = 35
        let radius: CGFloat = 15
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: radius, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // the beginning of the trough
        
        if selectedItem?.tag == 0 {
            // first curve down
            path.addCurve(to: CGPoint(x: centerWidth, y: height),
                          controlPoint1: CGPoint(x: (centerWidth - 20), y: 3),
                          controlPoint2: CGPoint(x: centerWidth - 38, y: height - 3))
            //  second curve up
            path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
                          controlPoint1: CGPoint(x: centerWidth + 38, y: height - 3),
                          controlPoint2: CGPoint(x: (centerWidth + 20), y: 3))
        }
        
        path.addLine(to: CGPoint(x: tabBarWidth - radius, y: 0))
        path.addArc(withCenter: CGPoint(x: tabBarWidth - radius, y: radius),
                    radius: radius,
                    startAngle:  3 * .pi / 2,
                    endAngle:  0,
                    clockwise: true)
        path.addLine(to: CGPoint(x: tabBarWidth, y: tabBarHeight))
        path.addLine(to: CGPoint(x: 0, y: tabBarHeight))
        path.addLine(to: CGPoint(x: 0, y: radius))
        path.addArc(withCenter: CGPoint(x: radius, y: radius),
                    radius: radius,
                    startAngle: .pi,
                    endAngle:  3 * .pi / 2,
                    clockwise: true)
        path.close()
        return path.cgPath
    }
}
