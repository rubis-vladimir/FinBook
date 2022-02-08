//
//  PieChartView.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.11.2021.
//

import UIKit

class PieChartView: UIView {
    
    private var circleLayer: CAShapeLayer!
    
    // Отрисовка диаграммы по секциям
    func draw(percents: [(String, Double)], colors: [UIColor]) {
        
        self.backgroundColor = UIColor.clear
        var alpha = CGFloat(Double.pi / 2)
        var betta = alpha
        
        for (index, section) in percents.enumerated() {
            let radian = 2 * Double.pi * section.1 / 100
            let color = colors[index]
            betta += CGFloat(radian)
            drawSection(alpha: alpha, betta: betta, color: color)
            alpha = betta
        }
    }
    
    // Отрисовка секции для соответствующей категории
    private func drawSection(alpha: CGFloat, betta: CGFloat, color: UIColor) {
        let arcColor: UIColor = ColorManager.shared.hexStringToUIColor(hex: Pallete.getPallete(model: UserDefaultManager.shared.retrieveThemeData()).bgColor)
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
    }
}
