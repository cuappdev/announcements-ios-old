//
//  AppDelegate.swift
//  iOS Tools
//
//  Created by Gonzalo Gonzalez on 10/6/19.
//  Copyright © 2019 Gonzalo Gonzalez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TestingViewController()
        window?.makeKeyAndVisible()

        return true
    }

}

