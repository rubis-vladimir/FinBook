//
//  MainTabBarController.swift
//  FinBook
//
//  Created by Владимир Рубис on 13.07.2021.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawTabBar(tabBar.items![0])
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        drawTabBar(item)
    }
    
    // MARK: - Customization TabBar
    
    private var tabBarWidth: CGFloat { self.tabBar.bounds.width }
    private var tabBarHeight: CGFloat { self.tabBar.bounds.height }
    private var centerWidth: CGFloat { self.tabBar.bounds.width / 2 }
    private var circleRadius: CGFloat { self.tabBar.bounds.height * 0.5 }
    
    private var shapeLayer: CALayer?
    
    // MARK: Outline TabBar
    
    private func shapePath(_ item: UITabBarItem) -> CGPath {
        
        let path = UIBezierPath()
        let height: CGFloat = 35.0
        let centerWidth = self.tabBar.frame.width / 2
        
        path.move(to: CGPoint(x: 15, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // the beginning of the trough
        
        if item.tag == 0 {
            // first curve down
            path.addCurve(to: CGPoint(x: centerWidth, y: height),
                          controlPoint1: CGPoint(x: (centerWidth - 22), y: 0), controlPoint2: CGPoint(x: centerWidth - 37, y: height))
            // second curve up
            path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
                          controlPoint1: CGPoint(x: centerWidth + 37, y: height), controlPoint2: CGPoint(x: (centerWidth + 22), y: 0))
        }
        
        // complete the rect
        path.addLine(to: CGPoint(x: self.tabBar.frame.width - 15, y: 0))
        path.addArc(withCenter: CGPoint(x: self.tabBar.frame.width - 15, y: 15),
                    radius: 15,
                    startAngle:  3 * .pi / 2,
                    endAngle:  0,
                    clockwise: true)
        path.addLine(to: CGPoint(x: self.tabBar.frame.width, y: self.tabBar.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.tabBar.frame.height))
        path.addLine(to: CGPoint(x: 0, y: 15))
        path.addArc(withCenter: CGPoint(x: 15, y: 15),
                    radius: 15,
                    startAngle: .pi,
                    endAngle:  3 * .pi / 2,
                    clockwise: true)
        path.close()
        return path.cgPath
    }
    
    private func drawTabBar(_ item: UITabBarItem) {
        let shapeLayer = CAShapeLayer()
        let horizontalPositionItems = [-10, -23, 10, 23]
        
        shapeLayer.path = shapePath(item)
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor(red: 155/255, green: 160/255, blue: 163/255, alpha: 1).cgColor
        shapeLayer.lineWidth = 3.0
        
        if let oldShapeLayer = self.shapeLayer {
            self.tabBar.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.tabBar.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        if item.tag == 0 {
            for item in tabBar.items! {
                item.titlePositionAdjustment.horizontal = CGFloat(horizontalPositionItems[item.tag])
            }
        } else {
            for item in tabBar.items! {
                item.titlePositionAdjustment.horizontal = 0
            }
        }
        self.shapeLayer = shapeLayer
    }
}
