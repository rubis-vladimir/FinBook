//
//  PieChartView.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.11.2021.
//

import UIKit

class PieChartView: UIView {
    
    private var circleLayer: CAShapeLayer!
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor.clear
        // заменить на случайные цвета
        let hexColors: [String] = ["767E8C", "CE5A57", "78A5A3", "E1B16A"]
        var colorSections: [UIColor] = []
        for i in 0..<hexColors.count {
            let newColor = hexStringToUIColor(hex: hexColors[i])
            colorSections.append(newColor)
        }
        
        let sections = calculateSection()
        var alpha = CGFloat(Double.pi / 2)
        var betta = alpha + sections[0]
        
        for (index, _) in sections.enumerated() {
            let color = colorSections[index]
            drawSection(alpha: alpha, betta: betta, color: color)
            alpha = betta
            if index != sections.count - 1 {
                betta += sections[index + 1]
            }
        }
    }
    
    private func calculateSection() -> [Double] {
        let expenses: [Double] = [20.0, 40.0, 10.0, 30.0]
        let summ = expenses.reduce(0, {x, y  in x + y})
        return expenses.map{ $0 * .pi * 2 / summ }
    }
    
    private func drawSection(alpha: CGFloat, betta: CGFloat, color: UIColor) {
        let arcColor: UIColor = UIColor.white
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = max(bounds.width, bounds.height) / 2
        let circlePatch = UIBezierPath(arcCenter: center, radius: radius, startAngle: alpha, endAngle: betta, clockwise: true)
        circlePatch.addArc(withCenter: center,
                    radius: 40,
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
        
//         Add animation
//        let animationRound = CABasicAnimation(keyPath: "strokeEnd")
//        animationRound.duration = 5
//        animationRound.fromValue = 0
//        animationRound.toValue = 1
//        circleLayer.add(animationRound, forKey: "lessAnimation")
    }
    
    private func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
