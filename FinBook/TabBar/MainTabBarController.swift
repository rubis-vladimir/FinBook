//
//  MainTabBarController.swift
//  FinBook
//
//  Created by Владимир Рубис on 13.07.2021.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    func changeTheme(answer: Bool) {
        print(answer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.itemPositioning = .fill
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateTabBar),
            name: Notification.Name(rawValue: "didReceiveNotification"),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateTabBar),
            name: Notification.Name(UIApplication.didBecomeActiveNotification.rawValue),
            object: nil)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        drawTabBar(item)
    }
    
    @objc func updateTabBar() {
        if let item = tabBar.selectedItem {
            drawTabBar(item) }
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
        let offsetItem = tabBar.bounds.width / 15
        let horizontalPositionItems = [0, -offsetItem , offsetItem , 0]
        let darkColor = UIColor.hex("2C2C2E").cgColor
        let lightColor = UIColor.hex("E5E5EA").cgColor
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shapePath(item)
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 1.5
        
        switch Theme.current {
        case .system:
            shapeLayer.fillColor = UIColor.isDark() ? darkColor : lightColor
        case .light:
            shapeLayer.fillColor = lightColor
        case .dark:
            shapeLayer.fillColor = darkColor
        }
    
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
        tabBar.tintColor = UIColor.systemMint
        self.shapeLayer = shapeLayer
        
//        self.tabBar.alpha = 0.0
//        UITabBar.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
//            self.tabBar.alpha = 1.0
//        }
//                         , completion: nil)
    }
}
