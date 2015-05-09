//
//  Project.swift
//  PropertyList
//
//  Created by Anıl Göktaş on 4/24/15.
//  Copyright (c) 2015 Anıl Göktaş. All rights reserved.
//

import UIKit

class Project: NSObject {
    
    // MARK: - Properties
    
    let key: String
    let name: String
    let detail: String
    let iTunesURL: NSURL
    let screenshot: UIImage
    let icon: UIImage
    
    // MARK: - Lifetime
    
    init(key: String, name: String, detail: String, iTunesURL: String) {
        self.key = key
        self.name = name
        self.detail = detail
        
        if let URL = NSURL(string: iTunesURL) {
            self.iTunesURL = URL
        } else {
            self.iTunesURL = NSURL(string: "https://twitter.com/goktasanil")!
        }
        
        if let image = UIImage(named: key+"Screen") {
            self.screenshot = image
        } else {
            self.screenshot = UIImage(named: "ScreenPlaceholder")!
        }
        
        if let icon = UIImage(named: key+"Icon") {
            self.icon = icon
        } else {
            self.icon = UIImage(named: "IconPlaceholder")!
        }
        super.init()
    }
    
    class func projects() -> [Project] {
        var projects = [Project]()
        
        // Parse Projects.plist
        if let
        path = NSBundle.mainBundle().pathForResource("Projects", ofType: "plist"),
        root = NSDictionary(contentsOfFile: path),
        projectKeys = root["ProjectKeys"] as? [String],
        projectInfos = root["Projects"] as? NSDictionary
        {
            // Find projects through keys array
            for projectKey in projectKeys {
                // Parse project info
                if let
                projectInfo = projectInfos[projectKey] as? NSDictionary,
                name = projectInfo["Name"] as? String,
                detail = projectInfo["Detail"] as? String,
                iTunesURL = projectInfo["iTunesURL"] as? String
                {
                    let project = Project(key: projectKey, name: name, detail: detail, iTunesURL: iTunesURL)
                    projects.append(project)
                }
            }
        }
        return projects
    }
   
}