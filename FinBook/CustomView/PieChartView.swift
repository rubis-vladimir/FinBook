//
//  PieChartView.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.11.2021.
//

import UIKit

class PieChartView: UIView {
    
    private var circleLayer: CAShapeLayer!
    
    func draw(_ rect: CGRect, sections: [String: Double], colors: [UIColor]) {
        self.backgroundColor = UIColor.clear
        var alpha = CGFloat(Double.pi / 2)
        var betta = alpha
        
        for (index, value) in sections.map({$1}).enumerated() {
                let color = colors[index]
                betta += CGFloat(value)
                drawSection(alpha: alpha, betta: betta, color: color)
                alpha = betta
        }
    }
    
    private func drawSection(alpha: CGFloat, betta: CGFloat, color: UIColor) {
        let arcColor: UIColor = UIColor.white
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = max(bounds.width, bounds.height) / 2
        let circlePatch = UIBezierPath(arcCenter: center,
                                       radius: radius,
                                       startAngle: alpha,
                                       endAngle: betta,
                                       clockwise: true)
        circlePatch.addArc(withCenter: center,
                           radius: radius / 3,
                           startAngle:  betta,
                           endAngle:  alpha,
                           clockwise: false)
        circlePatch.close()
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePatch.cgPath
        circleLayer.fillColor = color.cgColor
        circleLayer.strokeColor = arcColor.cgColor
        circleLayer.lineWidth = 6.0
        circleLayer.strokeEnd = 1.0
        layer.addSublayer(circleLayer)
        
        // Add animation
//        let animationRound = CABasicAnimation(keyPath: "strokeEnd")
//        animationRound.duration = 5
//        animationRound.fromValue = 0
//        animationRound.toValue = 1
//        circleLayer.add(animationRound, forKey: "lessAnimation")
    }
}
