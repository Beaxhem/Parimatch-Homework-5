//
//  ViewController.swift
//  HW5 Part 2
//
//  Created by Ilya Senchukov on 31.01.2021.
//

import UIKit

protocol Initiatable: UIViewController {
    init()
}

class ViewController: UIViewController {
    let viewControllers = [SnowAnimationView(), BirthdayAnimationView(), FireworksAnimationView()]
    
    @IBOutlet weak var scrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView?.isPagingEnabled = true
        
        createSlides()
    }
    
    private func createSlides() {
        guard let scrollView = scrollView else {
            return
        }
        
        let vcs: [Initiatable.Type] = [SnowAnimationView.self, BirthdayAnimationView.self, FireworksAnimationView.self]
        
        var frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        for vct in vcs {
            let vc = vct.init()
            
            vc.view.frame = frame
            
            addChild(vc)
            scrollView.addSubview(vc.view)
            vc.didMove(toParent: self)
            
            frame.origin.x += view.frame.width
        }
        
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(vcs.count), height: view.frame.height)
    }
}
