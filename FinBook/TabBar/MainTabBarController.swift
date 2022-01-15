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
    private var tabBarHeight: CGFloat { self.tabBar.bounds.height + 40 }
    private var centerWidth: CGFloat { self.tabBar.bounds.width / 2 }
    
    private var shapeLayer: CALayer?
    
    // MARK: Outline TabBar
    
    private func shapePath(_ item: UITabBarItem) -> CGPath {
        let height: CGFloat = 35
        let radius: CGFloat = 15
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: radius, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // the beginning of the trough
        
        if item.tag == 0 {
            // first curve down
            path.addCurve(to: CGPoint(x: centerWidth, y: height),
                          controlPoint1: CGPoint(x: (centerWidth - 20), y: 3),
                          controlPoint2: CGPoint(x: centerWidth - 38, y: height - 3))
            //  second curve up
            path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
                          controlPoint1: CGPoint(x: centerWidth + 38, y: height - 3),
                          controlPoint2: CGPoint(x: (centerWidth + 20), y: 3))
        }
        
        // complete the rect
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
    
    private func drawTabBar(_ item: UITabBarItem) {
        let horizontalPositionItems = [-10, -23, 23, 10]
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shapePath(item)
        shapeLayer.strokeColor = ColorManager.shared.hexStringToUIColor(hex: Pallete.getColorDecor().1).cgColor
        shapeLayer.fillColor = ColorManager.shared.hexStringToUIColor(hex: Pallete.getColorDecor().0).cgColor
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
        
        self.tabBar.alpha = 0.0
        UITabBar.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.tabBar.alpha = 1.0
            }, completion: nil)
    }
}
