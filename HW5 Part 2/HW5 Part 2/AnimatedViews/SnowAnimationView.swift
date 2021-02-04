//
//  SnowAnimationView.swift
//  HW5 Part 2
//
//  Created by Ilya Senchukov on 02.02.2021.
//

import UIKit

class SnowAnimationView: UIViewController, Initiatable {
    
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
}

extension SnowAnimationView {
    
    private func commonInit() {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        setupBackground()
        startAnimation()
    }
    
    private func setupBackground() {
        let startColor = UIColor(red: 32 / 255, green: 68 / 255, blue: 131 / 255, alpha: 1).cgColor
        let endColor = UIColor(red: 172 / 255, green: 184 / 255, blue: 207 / 255, alpha: 1).cgColor
        
        backgroundLayer.colors = [startColor, endColor]
        view.layer.addSublayer(backgroundLayer)
    }
    
    override func viewDidLayoutSubviews() {
        view.layer.addSublayer(emitterLayer)
        
        backgroundLayer.frame = view.bounds
        emitterLayer.frame = view.bounds
    }
}

extension SnowAnimationView {
    
    @objc func startAnimation() {
        view.layer.masksToBounds = true
        emitterLayer.emitterShape = .line
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: 0)
        emitterLayer.emitterSize = CGSize(width: view.bounds.size.width, height: 1)
        
        let snow = makeSnow()
      
        emitterLayer.emitterCells = [snow]
    }
    
    func makeSnow() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 10
        cell.lifetime = 20.0
        cell.lifetimeRange = 0
        cell.velocity = 80
        cell.velocityRange = 20
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 8
        cell.scale = 0.3
        cell.scaleRange = 0.1

        cell.contents = UIImage(named: "snow")?.cgImage
        
        return cell
    }
}
