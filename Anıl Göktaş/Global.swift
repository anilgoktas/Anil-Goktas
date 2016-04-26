//
//  Global.swift
//  Tiyatro Takip
//
//  Created by Anıl Göktaş on 10/14/15.
//  Copyright © 2015 Anıl Göktaş. All rights reserved.
//

import UIKit

// MARK: - Anıl Göktaş

struct AnilGoktas {
    
    static let fontString = "SFUIDisplay-Regular"
    static let appIconString = "largeAppIcon"
    
    struct ContactInfo {
        static let appStoreURL = "itms-apps://itunes.com/apps/anilgoktas"
        static let linkedInURL = "https://www.linkedin.com/in/anilgoktas"
        static let githubURL = "https://github.com/anilgoktas"
        static let twitterAddress = "@goktasanil"
        static let twitterURLString = "https://twitter.com/goktasanil"
        static let mailAddress = "goktas.anil@gmail.com"
        static let phoneNumber = "telprompt://00905374964735"
    }
    
    enum MainStoryboard {
        static let name = "Main"
        
        enum Identifier: String {
            case TabBarController
            case PopularViewController
        }
    }
    
}

// MARK: - Global Variables

let userDefaults       = NSUserDefaults.standardUserDefaults()
let iCloudDefaults     = NSUbiquitousKeyValueStore.defaultStore()
let notificationCenter = NSNotificationCenter.defaultCenter()
let mainOperationQueue = NSOperationQueue.mainQueue()
let application        = UIApplication.sharedApplication()
//let appDelegate        = AppDelegate.sharedDelegate()
let mainBundle         = NSBundle.mainBundle()

// MARK: - Typealias

typealias JSONDict = [String: AnyObject]