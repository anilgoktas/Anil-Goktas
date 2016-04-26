//
//  AboutViewController.swift
//  Anıl Göktaş
//
//  Created by Anıl Göktaş on 4/25/15.
//  Copyright (c) 2015 Anıl Göktaş. All rights reserved.
//

import UIKit
import CoreTelephony
import Social
import MessageUI

final class AboutViewController: UITableViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var phoneButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !SIMisAvailable() { phoneButton.hidden = true }
    }
    
    // MARK: - IBActions
    
    @IBAction func showAppStore(sender: AnyObject) {
        if let appStoreURL = NSURL(string: AnilGoktas.ContactInfo.appStoreURL) {
            UIApplication.sharedApplication().openURL(appStoreURL)
        }
    }
    
    @IBAction func showLinkedIn(sender: AnyObject) {
        if let linkedInURL = NSURL(string: AnilGoktas.ContactInfo.linkedInURL) {
            UIApplication.sharedApplication().openURL(linkedInURL)
        }
    }
    
    @IBAction func showGithub(sender: AnyObject) {
        if let githubURL = NSURL(string: AnilGoktas.ContactInfo.githubURL) {
            UIApplication.sharedApplication().openURL(githubURL)
        }
    }
    
    @IBAction func contactTwitter(sender: AnyObject) {
        let twitterViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        twitterViewController.setInitialText("Hey! " + AnilGoktas.ContactInfo.twitterAddress)
        presentViewController(twitterViewController, animated: true, completion: nil)
    }
    
    @IBAction func contactMail(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            let composer = MFMailComposeViewController()
            composer.mailComposeDelegate = self
            composer.setToRecipients([AnilGoktas.ContactInfo.mailAddress])
            composer.setSubject("Hey!")
            presentViewController(composer, animated: true, completion: nil)
        }
    }
    
    @IBAction func contactPhone(sender: AnyObject) {
        if let phoneURL = NSURL(string: AnilGoktas.ContactInfo.phoneNumber) {
            UIApplication.sharedApplication().openURL(phoneURL)
        }
    }
    
}

// MARK: - UITableViewDelegate

extension AboutViewController {
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 2 {
            return 100.0
        }
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, view.bounds.size.height/12))
        footerView.backgroundColor = .clearColor()
        return footerView
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return view.bounds.size.height/12
        }
        return 0.0
    }
    
}

// MARK: - MFMailComposeViewControllerDelegate

extension AboutViewController: MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(false, completion: nil)
    }
    
}

// MARK: - Helper Functions

extension AboutViewController {
    
    private func SIMisAvailable() -> Bool {
        if let
            cellularProvider  = CTTelephonyNetworkInfo().subscriberCellularProvider,
            _ = cellularProvider.mobileNetworkCode
        { return true }
        return false
    }
    
}