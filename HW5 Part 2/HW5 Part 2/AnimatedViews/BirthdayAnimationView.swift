//
//  BirthdayAnimationView.swift
//  HW5 Part 2
//
//  Created by Ilya Senchukov on 02.02.2021.
//

import UIKit

class BirthdayAnimationView: UIViewController, Initiatable {
    
    let emitterLayer = CAEmitterLayer()
    let backgroundLayer = CAGradientLayer()
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        setupBackground()
        
        view.layer.addSublayer(emitterLayer)
        startAnimation()
    }
    
    private func setupBackground() {
        
        
        let startColor = UIColor(red: 32 / 255, green: 68 / 255, blue: 231 / 255, alpha: 1).cgColor
        let endColor = UIColor(red: 172 / 255, green: 184 / 255, blue: 207 / 255, alpha: 1).cgColor
        backgroundLayer.colors = [startColor, endColor]
        view.layer.addSublayer(backgroundLayer)
    }
    
    override func viewDidLayoutSubviews() {
        backgroundLayer.frame = view.bounds
        emitterLayer.frame = view.bounds
    }
}

extension BirthdayAnimationView {
    func startAnimation() {
        view.layer.masksToBounds = true
        emitterLayer.emitterSize = CGSize(width: view.bounds.width, height: 1)
        emitterLayer.emitterShape = .line
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: -50)
        
        let red = makeConfetti(color: UIColor.red)
        let green = makeConfetti(color: UIColor.green)
        let blue = makeConfetti(color: UIColor.blue)
        
        emitterLayer.emitterCells = [red, green, blue]
    }
    
    private func makeConfetti(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        
        cell.birthRate = 4
        cell.color = color.cgColor
        cell.lifetime = 15.0
        cell.lifetimeRange = 0
        cell.velocity = 100
        cell.velocityRange = 30
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 4
        cell.scale = 0.7
        cell.scaleRange = 0.5
        cell.spin = 3
        cell.spinRange = 1
        
        cell.contents = UIImage(named: "confetti")?.cgImage
        
        return cell
    }
}
