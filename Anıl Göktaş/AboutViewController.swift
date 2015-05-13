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

class AboutViewController: UITableViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var phoneButton: UIButton!
    
    // MARK: - Properties
    
    private struct ContactInfo {
        static let appStoreURL = "itms-apps://itunes.com/apps/anilgoktas"
        static let linkedInURL = "https://www.linkedin.com/in/anilgoktas"
        static let githubURL = "https://github.com/anilgoktas"
        static let twitterAddress = "@goktasanil"
        static let mailAddress = "goktas.anil@gmail.com"
        static let phoneNumber = "telprompt://00905374964735"
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        
        if !SIMisAvailable() { phoneButton.hidden = true }
    }
    
    // MARK: - IBActions
    
    @IBAction func showAppStore(sender: AnyObject) {
        if let appStoreURL = NSURL(string: ContactInfo.appStoreURL) {
            UIApplication.sharedApplication().openURL(appStoreURL)
        }
    }
    
    @IBAction func showLinkedIn(sender: AnyObject) {
        if let linkedInURL = NSURL(string: ContactInfo.linkedInURL) {
            UIApplication.sharedApplication().openURL(linkedInURL)
        }
    }
    
    @IBAction func showGithub(sender: AnyObject) {
        if let githubURL = NSURL(string: ContactInfo.githubURL) {
            UIApplication.sharedApplication().openURL(githubURL)
        }
    }
    
    @IBAction func contactTwitter(sender: AnyObject) {
        let twitterViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        twitterViewController.setInitialText("Hey! " + ContactInfo.twitterAddress)
        presentViewController(twitterViewController, animated: true, completion: nil)
    }
    
    @IBAction func contactMail(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            let composer = MFMailComposeViewController()
            composer.mailComposeDelegate = self
            composer.setToRecipients([ContactInfo.mailAddress])
            composer.setSubject("Hey!")
            presentViewController(composer, animated: true, completion: nil)
        }
    }
    
    @IBAction func contactPhone(sender: AnyObject) {
        if let phoneURL = NSURL(string: ContactInfo.phoneNumber) {
            UIApplication.sharedApplication().openURL(phoneURL)
        }
    }
    
    // MARK: - Private
    
    private func SIMisAvailable() -> Bool {
        if let
        cellularProvider  = CTTelephonyNetworkInfo().subscriberCellularProvider,
        mobileNetworkCode = cellularProvider.mobileNetworkCode
        { return true }
        return false
    }

}

// MARK: - UITableViewDelegate

extension AboutViewController: UITableViewDelegate {
    
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
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        dismissViewControllerAnimated(false, completion: nil)
    }
    
}