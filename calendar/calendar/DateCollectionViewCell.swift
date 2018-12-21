//
//  DateCollectionViewCell.swift
//  calendar
//
//  Created by Alfonso Castanos on 12/20/18.
//  Copyright © 2018 Alfonso Castanos. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var Circle: UIView!
    @IBOutlet weak var DateLabel: UILabel!
    
    func DrawCricle(){
        let circleCenter = Circle.center
        let circlePath = UIBezierPath(arcCenter: circleCenter, radius: (Circle.bounds.width/2-5), startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        let CircleLayer = CAShapeLayer()
        CircleLayer.path = circlePath.cgPath
        CircleLayer.strokeColor = UIColor(displayP3Red: 0.45, green: 0.67, blue: 0.27, alpha: 1.0).cgColor
        CircleLayer.lineWidth = 2
        CircleLayer.strokeEnd = 0
        CircleLayer.fillColor = UIColor.clear.cgColor //Fill color set to clear circle
        CircleLayer.lineCap = CAShapeLayerLineCap.round
        
        let Animation = CABasicAnimation(keyPath: "strokeEnd")
        Animation.duration = 1.5
        Animation.toValue = 1
        Animation.fillMode = CAMediaTimingFillMode.forwards
        Animation.isRemovedOnCompletion = false
        
        CircleLayer.add(Animation, forKey: nil)
        Circle.layer.addSublayer(CircleLayer)
        Circle.layer.backgroundColor = UIColor.clear.cgColor
        
    }
    
    func FillEvent(){
        let circleCenter = Circle.center
        let circlePath = UIBezierPath(arcCenter: circleCenter, radius: (Circle.bounds.width/2-5), startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        let CircleLayer = CAShapeLayer()
        CircleLayer.path = circlePath.cgPath
        CircleLayer.strokeColor = UIColor.yellow.cgColor
        CircleLayer.lineWidth = 2
        CircleLayer.strokeEnd = 0
        CircleLayer.fillColor = UIColor.yellow.cgColor //Fill color set to clear circle
        CircleLayer.lineCap = CAShapeLayerLineCap.round
        
        Circle.layer.addSublayer(CircleLayer)
        Circle.layer.backgroundColor = UIColor.clear.cgColor
    }
}
