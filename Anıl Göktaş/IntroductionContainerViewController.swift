//
//  IntroductionContainerViewDelegate.swift
//  Anıl Göktaş
//
//  Created by Anıl Göktaş on 4/26/15.
//  Copyright (c) 2015 Anıl Göktaş. All rights reserved.
//

import UIKit

protocol IntroductionContainerViewDelegate: class {
    func segue()
}

class IntroductionContainerViewController: UITableViewController {
    
    // MARK: - Properties
    
    weak var delegate: IntroductionContainerViewDelegate?

}

// MARK: - UITableViewDelegate

extension IntroductionContainerViewController: UITableViewDelegate {
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70.0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let
        introductionController = delegate as? IntroductionViewController,
        segueDestination = IntroductionViewController.MainStoryboard.SegueDestination(rawValue: indexPath.row)
        {
            IntroductionViewController.MainStoryboard.segueDestination = segueDestination
            introductionController.segue()
        }
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, view.bounds.size.height/25))
        footerView.backgroundColor = .clearColor()
        
        return footerView
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return view.bounds.size.height/25
    }
    
}