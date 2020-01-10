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
  private let presenter: UINavigationController

  init(_ window: UIWindow, navController: UINavigationController) {
    self.window = window
    self.presenter = navController
    self.presenter.navigationBar.prefersLargeTitles = true
  }

  func start() {
    window.rootViewController = presenter
    startBreakingList()
    window.makeKeyAndVisible()
  }
  
  private func startBreakingList() {
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    guard let vc = storyBoard.instantiateViewController(withIdentifier: String(describing: BreakingListViewController.self)) as? BreakingListViewController else { return }

    let viewModel = BreakingListViewModel()
    vc.viewModel = viewModel
    presenter.pushViewController(vc, animated: true)
  }
}
