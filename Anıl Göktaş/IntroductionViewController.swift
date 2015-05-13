//
//  IntroductionViewController.swift
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
    
    struct MainStoryboard {
        private struct SegueIdentifier {
            static let container = "toContainer"
            static let tabBar = "toTabBar"
        }
        enum SegueDestination: Int {
            case Projects=1, About
        }
        static var segueDestination = SegueDestination.Projects
    }
    
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
        // Segue to Container
        if let containerViewController = segue.destinationViewController as? IntroductionContainerViewController
            where segue.identifier == MainStoryboard.SegueIdentifier.container {
            containerViewController.delegate = self
        }
        // Segue to TabBar
        if let tabBarController = segue.destinationViewController as? UITabBarController
            where segue.identifier == MainStoryboard.SegueIdentifier.tabBar {
            tabBarController.selectedIndex = MainStoryboard.segueDestination.rawValue-1
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
                // Scale picture
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.profileImageView.transform = CGAffineTransformMakeScale(0.000001, 0.000001)
                })
            })
        }
    }
    
    func delay(delay: Double, closure: () -> ()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

}

// MARK: - IntroductionContainerViewDelegate

extension IntroductionViewController: IntroductionContainerViewDelegate {
    
    func segue() {
        hideIntroduction()
        delay(1.9) {
            self.performSegueWithIdentifier(MainStoryboard.SegueIdentifier.tabBar, sender: nil)
        }
    }
    
}