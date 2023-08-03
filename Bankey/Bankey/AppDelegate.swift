//
//  AppDelegate.swift
//  Bankey
//
//  Created by Pin Lu on 8/1/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.backgroundColor = .systemBackground
//        window.rootViewController = LoginViewController()
        window.rootViewController = OnboardingContainerViewController()
        
        self.window = window
        return true
    }

}

