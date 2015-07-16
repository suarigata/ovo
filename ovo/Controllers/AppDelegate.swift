//
//  AppDelegate.swift
//  ovo
//
//  Created by iOS on 7/15/15
//  Copyright (c) 2015 . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        let appearance = UINavigationBar.appearance()
        appearance.barTintColor = UIColor.orangeColor()
        let attrs = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        appearance.titleTextAttributes = attrs
        appearance.tintColor = UIColor.whiteColor()
        return true
    }
    
//    func applicationDidFinishLaunching(application: UIApplication) {
//        let appearance = UINavigationBar.appearance()
//        appearance.barTintColor = UIColor.orangeColor()
//        let attrs = [NSForegroundColorAttributeName: UIColor.whiteColor()]
//        appearance.titleTextAttributes = attrs
//        appearance.tintColor = UIColor.whiteColor()
//    }
}
