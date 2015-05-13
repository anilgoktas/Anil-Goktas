//
//  ProjectViewController.swift
//  Anıl Göktaş
//
//  Created by Anıl Göktaş on 4/26/15.
//  Copyright (c) 2015 Anıl Göktaş. All rights reserved.
//

import UIKit

class ProjectViewController: UITableViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var iconImageView: ImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var screenImageView: ImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Properties
    
    var index = 0
    var project: Project!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconImageView.image = project.icon
        nameLabel.text = project.name
        detailLabel.text = project.detail
        if let image = UIImage(named: project.key+"Screen") {
            screenImageView.image = image
        } else {
            screenImageView.image = UIImage(named: "ScreenPlaceholder")!
        }
        pageControl.currentPage = index
    }
    
    override func viewDidLayoutSubviews() {
        screenImageView.borderWidth = 0.3
    }
    
}

// MARK: - UITableViewDelegate

extension ProjectViewController: UITableViewDelegate {
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120.0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // Show app store
        if indexPath.row == 2 {
            UIApplication.sharedApplication().openURL(project.iTunesURL)
        }
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, view.bounds.size.height/12))
        footerView.backgroundColor = .clearColor()
        
        return footerView
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return view.bounds.size.height/12
    }
    
}