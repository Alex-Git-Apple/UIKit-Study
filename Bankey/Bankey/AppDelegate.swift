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
    
    let loginViewController = LoginViewController()
    
    let onboardingContainerViewController = OnboardingContainerViewController()
    
    let dummyVC = DummyViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.backgroundColor = .systemBackground
        
        onboardingContainerViewController.delegate = self
        dummyVC.logoutDelegate = self

        loginViewController.delegate = self
        window.rootViewController = loginViewController
        
        self.window = window
        return true
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.9,
                          options: .transitionCrossDissolve,
                          animations: nil)
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(dummyVC)
        } else {
            setRootViewController(onboardingContainerViewController)
        }
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnBoarding() {
        LocalState.hasOnboarded = true
        setRootViewController(dummyVC)
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogOut() {
        setRootViewController(loginViewController)
    }
}

