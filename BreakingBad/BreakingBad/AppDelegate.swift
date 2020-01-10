//
//  AppDelegate.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 09/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


  var window: UIWindow?
  private var applicationCoordinator: Coordinator?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    let navController = UINavigationController()
    navController.navigationBar.barTintColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    let applicationCoordinator = ApplicationCoordinator(window, navController: navController)
    self.window = window
    self.applicationCoordinator = applicationCoordinator
    applicationCoordinator.start()
    return true
    
  }
}

