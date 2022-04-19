//
//  PieChartView.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.11.2021.
//

import UIKit

// MARK: Кастомный вью, на котором 
final class PieChartView: UIView {
    
    private var circleLayer: CAShapeLayer!
    
    /// Посекционно рисует круговую диаграмму
    ///  - Parameters:
    ///   - percents: массив кортежей (категория, процент от общей стоимости)
    ///   - colors: массив цветов
    func draw(percents: [(String, Double)], colors: [UIColor]) {
        var alpha = CGFloat(Double.pi / 2)
        var betta = alpha
        
        for (persent, color) in zip(percents, colors) {
            let radian = 2 * Double.pi * persent.1 / 100
            betta += CGFloat(radian)
            
            drawSection(alpha: alpha, betta: betta, color: color)
            alpha = betta
        }
    }
    
    /// Отрисовывает секцию
    /// - Parameters:
    ///   - alpha: начальный угол
    ///   - betta: конечный угол
    ///   - color: цвет секции
    private func drawSection(alpha: CGFloat, betta: CGFloat, color: UIColor) {
        let arcColor = UIColor.systemGray4
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
