//
//  AppDelegate.swift
//  CruxAR
//
//  Created by Andrew on 2015-10-27.
//  Copyright © 2015 CruxAR. All rights reserved.
//

import UIKit

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var shortcutItem: UIApplicationShortcutItem?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        print("Application did finish launching with options")
        
        var performShortcutDelegate = true
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            
            print("Application launched via shortcut")
            self.shortcutItem = shortcutItem
            
            performShortcutDelegate = false
        }
        
        return performShortcutDelegate
        
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        
        print("Application performActionForShortcutItem")
        completionHandler( handleShortcut(shortcutItem) )
        
    }
    
    func handleShortcut( shortcutItem:UIApplicationShortcutItem ) -> Bool {
        print("Handling shortcut")
        
        var succeeded = false
        
        if( shortcutItem.type == "ca.cruxAR.crux.AR.LaunchARScan" ) {
            print("Launching ARScan")
            
            // Add your code here
            print("- Handling \(shortcutItem.type)")
            
            // Get the view controller you want to load
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let ARScanVC = mainSB.instantiateViewControllerWithIdentifier("CXARViewController") as! CXARViewController
            
            
            let navVC = self.window?.rootViewController as! UINavigationController
            navVC.navigationBar.translucent = true
            navVC.pushViewController(ARScanVC, animated: true)
            
            succeeded = true
            
        }
        
        if( shortcutItem.type == "ca.cruxAR.crux.AR.LaunchARMap" ) {
             print("Launching ARMap")
            
            // Add your code here
            print("- Handling \(shortcutItem.type)")
            
            // Get the view controller you want to load
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let ARMap = mainSB.instantiateViewControllerWithIdentifier("CXMapViewController") as! CXMapViewController
            
            
            let navVC = self.window?.rootViewController as! UINavigationController
            navVC.pushViewController(ARMap, animated: true)
            
            succeeded = true
            
        }
        
        
        
        return succeeded
        
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        print("Application did become active")
        
        guard let shortcut = shortcutItem else { return }
        
        print("- Shortcut property has been set")
        
        handleShortcut(shortcut)
        
        self.shortcutItem = nil
        
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        
        print("Application did enter Background")
        NSNotificationCenter.defaultCenter().postNotificationName("popToRoot", object: nil)
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        print("Application did enter Foreground")
        NSNotificationCenter.defaultCenter().postNotificationName("popToRoot", object: nil)

    }}

