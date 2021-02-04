//
//  FireworksAnimationView.swift
//  HW5 Part 2
//
//  Created by Ilya Senchukov on 02.02.2021.
//

import UIKit

class FireworksAnimationView: UIViewController, Initiatable {
    
    let backgroundLayer = CAGradientLayer()
    let emitterLayer = CAEmitterLayer()

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
    
    override func viewDidLayoutSubviews() {
        backgroundLayer.frame = view.bounds
        emitterLayer.frame = view.bounds
    }
    
    private func setupBackground() {
        let startColor = UIColor(red: 32 / 255, green: 68 / 255, blue: 231 / 255, alpha: 1).cgColor
        let endColor = UIColor(red: 172 / 255, green: 184 / 255, blue: 207 / 255, alpha: 1).cgColor
        backgroundLayer.colors = [startColor, endColor]
        view.layer.addSublayer(backgroundLayer)
    }
}

extension FireworksAnimationView {
    func startAnimation() {
        view.layer.masksToBounds = true
        
        emitterLayer.emitterShape = .point
        emitterLayer.emitterPosition = CGPoint(x: view.frame.width / 2, y:view.frame.height)
//        emitterLayer.position = CGPoint(x: view.frame.width / 2, y:view.frame.height)
//        emitterLayer.emitterSize = CGSize(width: 1, height: 1)
        emitterLayer.renderMode = .additive
        
        let emitterCell = CAEmitterCell()
        
        emitterCell.emissionLongitude = .pi / 2
        emitterCell.emissionLatitude = 0
        emitterCell.lifetime = 2.6
        emitterCell.birthRate = 1
        emitterCell.velocity = -300
        emitterCell.velocityRange = 100
        emitterCell.yAcceleration = -150
        emitterCell.emissionRange = .pi / 4
        emitterCell.color = UIColor(white: 0.5, alpha: 0.7).cgColor
        
        emitterCell.redRange = 0.9
        emitterCell.greenRange = 0.9
        emitterCell.blueRange = 0.9
        
        let flareCell = makeFlareCell()
        let fireworkCell = makeFireworkCell()

        emitterCell.emitterCells = [flareCell,fireworkCell]
        emitterLayer.emitterCells = [emitterCell]
    }
    
    private func makeFlareCell() -> CAEmitterCell {
        let flareCell =  CAEmitterCell()

        flareCell.contents = UIImage(named: "spark")?.cgImage
        flareCell.emissionLongitude = .pi / 2
        flareCell.scale = 0.4
        flareCell.velocity = 80
        flareCell.birthRate = 45
        flareCell.lifetime = 0.5
        flareCell.yAcceleration = -350
        flareCell.emissionRange = .pi / 6
        flareCell.alphaSpeed = -0.7
        flareCell.scaleSpeed = -0.1
        flareCell.scaleRange = 0.1
        flareCell.beginTime = 0.01
        flareCell.duration = 1.5
        
        return flareCell
    }
    
    private func makeFireworkCell() -> CAEmitterCell {
        let fireworkCell = CAEmitterCell()
        
        fireworkCell.contents = UIImage(named: "bokeh")?.cgImage
        fireworkCell.birthRate = 3000
        fireworkCell.scale = 0.5
        fireworkCell.velocity = 200
        fireworkCell.lifetime = 2.5
        fireworkCell.alphaSpeed = -0.2
        fireworkCell.yAcceleration = -80
        fireworkCell.beginTime = 1.5
        fireworkCell.duration = 0.1
        fireworkCell.emissionRange = 2 * .pi
        fireworkCell.scaleSpeed = -0.1
        fireworkCell.spin = 2
        
        return fireworkCell
    }
}

