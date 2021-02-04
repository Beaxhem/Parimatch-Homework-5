//
//  AnimationView.swift
//  HW5 Part 1
//
//  Created by Ilya Senchukov on 31.01.2021.
//

import UIKit

class AnimationView: UIView {
    private let duration: TimeInterval = 1.5
    private let circlesCount = 3
    private let radius: CGFloat = 100
    
    var isAnimating = false
    
    private let shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        layer.addSublayer(shapeLayer)
    }
    
    func updateAnimation() {
        for i in 0..<circlesCount {
            let color = UIColor.red
            
            makeCircle(color: color, index: i)
        }
    }
    
    func makeCircle(color: UIColor, index: Int) {
        let circle = CAShapeLayer()
        let path = UIBezierPath(arcCenter: CGPoint(
                                    x: frame.width / 2,
                                    y: frame.height / 2),
                                radius: radius,
                                startAngle: 0,
                                endAngle: CGFloat(Double.pi * 2),
                                clockwise: false)
        
        circle.path = path.cgPath
        circle.fillColor = color.cgColor
        
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.repeatCount = Float(Int.max)
        
        let positionXAnimation = CABasicAnimation(keyPath: "position.x")
        positionXAnimation.fromValue = frame.width / 2
        positionXAnimation.toValue = 0
        
        let positionYAnimation = CABasicAnimation(keyPath: "position.y")
        positionYAnimation.fromValue = frame.height / 2
        positionYAnimation.toValue = 0
    
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        
        let group = CAAnimationGroup()
        
        group.animations = [scaleAnimation, positionXAnimation, positionYAnimation, opacityAnimation]
        group.duration = duration
        group.timeOffset = 0.3 * Double(index)
        group.repeatCount = Float(Int.max)
        group.timingFunction = CAMediaTimingFunction(name: .easeOut)
        circle.add(group, forKey: nil)
        
        shapeLayer.addSublayer(circle)
    }
}

extension AnimationView {
    func start() {
        updateAnimation()
    }
    
    func stop() {
        self.shapeLayer.removeAllAnimations()
    }
}
