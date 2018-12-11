//
//  AppDelegate.swift
//  Example
//
//  Created by DianQK on 2018/12/11.
//  Copyright © 2018 DianQK. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let keyWindow = UIWindow(frame: UIScreen.main.bounds)
        self.window = keyWindow
        keyWindow.makeKeyAndVisible()
        keyWindow.rootViewController = LayoutViewController()

        return true
    }

}

