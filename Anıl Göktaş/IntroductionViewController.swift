//
//  ViewController.swift
//  Anıl Göktaş
//
//  Created by Anıl Göktaş on 4/24/15.
//  Copyright (c) 2015 Anıl Göktaş. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var profileImageView: ImageView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Properties
    
    struct Storyboard {
        enum SegueDestination: Int {
            case Projects=1, About
        }
    }
    var segueDestination = Storyboard.SegueDestination.Projects
    
    // MARK: - View Life Cycle
    
    override func viewDidLayoutSubviews() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.size.height/2
        profileImageView.layer.masksToBounds = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        showIntroduction()
    }
    
    // MARK: - UIStoryboardSegue Handling
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let containerViewController = segue.destinationViewController as? IntroductionContainerViewController where segue.identifier == "toContainer" {
            containerViewController.delegate = self
        }
        if let tabBarController = segue.destinationViewController as? UITabBarController where segue.identifier == "toMain" {
            switch segueDestination {
            case .Projects: tabBarController.selectedIndex = 0
            case .About: tabBarController.selectedIndex = 1
            }
        }
    }
    
    // MARK: - Animations
    
    override func shouldAutorotate() -> Bool { return false }
    
    func showIntroduction() {
        // Move picture to top
        UIView.animateWithDuration(1.5, animations: { () -> Void in
            self.profileImageView.transform = CGAffineTransformMakeTranslation(0, -4.5*(self.view.bounds.height/12))
            }) { (completed) -> Void in
                // Show table view
                UIView.animateWithDuration(1.5, animations: { () -> Void in
                    self.containerView.alpha = 1.0
                })
        }
    }
    
    func hideIntroduction() {
        // Hide table view
        UIView.animateWithDuration(0.75, animations: { () -> Void in
            self.containerView.alpha = 0.0
        }) { (completed) -> Void in
            // Move picture to center
            UIView.animateWithDuration(0.75, animations: { () -> Void in
                self.profileImageView.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: { (completed) -> Void in
                // Fade picture and segue
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.profileImageView.transform = CGAffineTransformMakeScale(0.000001, 0.000001)
                }, completion: { (completed) -> Void in
                    self.performSegueWithIdentifier("toMain", sender: nil)
                })
            })
        }
    }

}

// MARK: - IntroductionContainerViewDelegate

extension IntroductionViewController: IntroductionContainerViewDelegate {
    
    func segue() {
        hideIntroduction()
    }
    
}