//
//  Project.swift
//  Anıl Göktaş
//
//  Created by Anıl Göktaş on 4/24/15.
//  Copyright (c) 2015 Anıl Göktaş. All rights reserved.
//

import UIKit

final class Project: NSObject {
    
    // MARK: - Properties
    
    let key: String
    var name: String
    var detail: String
    var iTunesURL: NSURL
    var icon: UIImage
    
    // MARK: - Life Cycle
    
    init(key: String, name: String, detail: String, iTunesURL: String) {
        self.key = key
        self.name = name
        self.detail = detail
        
        if let URL = NSURL(string: iTunesURL) {
            self.iTunesURL = URL
        } else {
            self.iTunesURL = NSURL(string: AnilGoktas.ContactInfo.twitterURLString)!
        }
        
        if let icon = UIImage(named: key + "Icon") {
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