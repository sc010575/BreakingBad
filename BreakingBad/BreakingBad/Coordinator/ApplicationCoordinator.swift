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
  private let navigationcontroller: UINavigationController
  private var coordinators = [String: Coordinator]()
  
  init(_ window: UIWindow) {
      self.window = window
      navigationcontroller = UINavigationController()
  }
  
  func start() {
      window.rootViewController = navigationcontroller
      startNewScene()
      window.makeKeyAndVisible()
  }
  
  private func startNewScene() {
    
  }

}
