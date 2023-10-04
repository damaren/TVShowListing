//
//  AppDelegate.swift
//  TVShows
//
//  Created by José Damaren on 23/06/23.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let coordinator: TVShowSearchCoordinator = TVShowSearchCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = coordinator.navigationController
        
        return true
    }
}
