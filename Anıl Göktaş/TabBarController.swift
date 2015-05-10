//
//  TabBarController.swift
//  Anıl Göktaş
//
//  Created by Anıl Göktaş on 4/26/15.
//  Copyright (c) 2015 Anıl Göktaş. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        createMask()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animateMask()
    }
    
    // MARK: - Animations
    
    func createMask() {
        view.layer.mask = CALayer()
        view.layer.mask.contents = UIImage(named: "CircleProfile")!.CGImage
        view.layer.mask.bounds = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
        view.layer.mask.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        view.layer.mask.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
    }
    
    func animateMask() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 1
        keyFrameAnimation.beginTime = CACurrentMediaTime()
        let initalBounds = NSValue(CGRect: view.layer.mask.bounds)
        let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 90, height: 90))
        let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 1500, height: 1500))
        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        view.layer.mask.addAnimation(keyFrameAnimation, forKey: "bounds")
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        // Remove mask when animation completes
        view.layer.mask = nil
    }

}