//
//  AppDelegate.swift
//  favoriteList
//
//  Created by ALEKSANDR POZDNIKIN on 04.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = ViewController()
        
        // Override point for customization after application launch.
        return true
    }

}

