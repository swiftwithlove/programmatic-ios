//
//  AppDelegate.swift
//  single-view-template
//
//  Created by Adam Dahan on 2019-02-04.
//  Copyright © 2019 Adam. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties

    var window: UIWindow?
    
    // MARK: - Lifecycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setup()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        NotificationCenter.default.post(name: NSNotification.Name("SAVE_DATA"), object: nil)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupWindow()
        setupStatusBar()
    }
    
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = UINavigationController(
            rootViewController: ViewControllerA()
        )
            
        window?.makeKeyAndVisible()
    }
    
    func setupStatusBar() {
        UIApplication.shared.statusBarStyle = .lightContent
    }
}

