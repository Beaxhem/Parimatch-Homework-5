//
//  ViewController.swift
//  HW5 Part 1
//
//  Created by Ilya Senchukov on 31.01.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startAnimation() {
        animationView?.start()
    }
    
    @IBAction func stopAnimation() {
        animationView?.stop()
    }

}

