//
//  AppDelegate.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 09/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    static func makeNavigationController(_ viewModel: BreakingListViewModelUseCase = BreakingListViewModel()) -> CustomNavigationController {
        let viewModel = viewModel
        let navController = CustomNavigationController(rootViewController: BreakingListViewController(viewModel: viewModel))
        return navController

    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


  var window: UIWindow?
  private var applicationCoordinator: Coordinator?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    let navController = CustomNavigationController.makeNavigationController()
    navController.navigationBar.barTintColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    let applicationCoordinator = ApplicationCoordinator(window, navController: navController)
    self.window = window
    self.applicationCoordinator = applicationCoordinator
    applicationCoordinator.start()
    return true
    
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

