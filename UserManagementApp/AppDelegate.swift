//
//  AppDelegate.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/3/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        coordinator = MainCoordinator(UINavigationController())
        window?.rootViewController = coordinator.navigationViewController
        coordinator.start()
        return true
    }


}

