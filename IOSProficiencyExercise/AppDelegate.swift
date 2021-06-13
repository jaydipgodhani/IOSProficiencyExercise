//
//  AppDelegate.swift
//  IOSProficiencyExercise
//
//  Created by Jaydip Godhani on 13/06/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(rootViewController: HomeViewController())
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }


}

