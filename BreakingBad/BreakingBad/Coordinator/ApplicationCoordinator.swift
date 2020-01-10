//
//  ApplicationCoordinator.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 10/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {

  private let window: UIWindow
  private let navigationController: UINavigationController

  init(_ window: UIWindow, navController: CustomNavigationController) {
    self.window = window
    self.navigationController = UINavigationController()
    self.navigationController.navigationBar.prefersLargeTitles = true
  }

  func start() {
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
}
