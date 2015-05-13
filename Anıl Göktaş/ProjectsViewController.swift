//
//  ProjectsViewController.swift
//  Anıl Göktaş
//
//  Created by Anıl Göktaş on 4/26/15.
//  Copyright (c) 2015 Anıl Göktaş. All rights reserved.
//

import UIKit

class ProjectsViewController: UIPageViewController {
    
    // MARK: - Properties
    
    let projects = Project.projects()
    struct Storyboard {
        static let projectViewControllerIdentifier = "ProjectViewControllerIdentifier"
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the data source to itself
        dataSource = self
        
        // Create the first walkthrough screen
        if let startingViewController = self.viewControllerAtIndex(0) {
            setViewControllers([startingViewController], direction: .Forward, animated: true, completion: nil)
        }
    }

}

// MARK: - UIPageViewControllerDataSource

extension ProjectsViewController: UIPageViewControllerDataSource {
    
    func viewControllerAtIndex(index: Int) -> ProjectViewController? {
        if index == NSNotFound || index < 0 || index >= projects.count {
            return nil
        }
        // Create a new view controller and pass data.
        if let projectViewController = storyboard?.instantiateViewControllerWithIdentifier(Storyboard.projectViewControllerIdentifier) as? ProjectViewController {
            projectViewController.project = projects[index]
            projectViewController.index = index
            return projectViewController
        }
        return nil
    }
    
    func forward(index: Int) {
        if let nextViewController = self.viewControllerAtIndex(index+1) {
            setViewControllers([nextViewController], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ProjectViewController).index
        index++
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ProjectViewController).index
        index--
        return self.viewControllerAtIndex(index)
    }
    
}