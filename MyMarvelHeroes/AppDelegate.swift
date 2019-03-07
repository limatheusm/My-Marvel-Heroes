//
//  AppDelegate.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 15/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        CoreDataStack.sharedInstance.load()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataStack.sharedInstance.save()
    }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStack.sharedInstance.save()
    }
}

