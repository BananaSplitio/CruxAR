//
//  ViewController.swift
//  CruxAR
//
//  Created by Andrew on 2015-10-27.
//  Copyright © 2015 CruxAR. All rights reserved.
//

import UIKit
import CoreLocation

class CXMainViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    
    func popToRootViewController() {
        self.navigationController?.popToRootViewControllerAnimated(true)
        print("popToRoot")
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("popToRootViewController"), name: "popToRoot", object: nil)
        
        let navController = self.navigationController
        
        
        navController?.setNavigationBarHidden(true, animated: true)
        navController?.setToolbarHidden(true, animated: true)
        
        super.viewDidLoad()
                }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
          if (segue.identifier == "ScanAR") {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
           self.navigationController?.navigationBar.translucent = true

        
        }
    }
    override func viewDidAppear(animated: Bool) {
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization() }

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
