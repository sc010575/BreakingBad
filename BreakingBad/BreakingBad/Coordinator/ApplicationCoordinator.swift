//
//  ApplicationCoordinator.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 10/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation
import UIKit
import Reachability

class ApplicationCoordinator: Coordinator {

  private let window: UIWindow
  private let presenter: UINavigationController
  private let storyBoard = UIStoryboard(name: "Main", bundle: nil)
  private var connectivityHandler: ConnectivityHandler?

  init(_ window: UIWindow, navController: UINavigationController) {
    self.window = window
    self.presenter = navController
    self.presenter.navigationBar.prefersLargeTitles = true
  }
  func start() {
    setupReachability()
    window.rootViewController = presenter
    startBreakingList()
    window.makeKeyAndVisible()
  }

  private func startBreakingList() {
    guard let vc = storyBoard.instantiateViewController(withIdentifier: String(describing: BreakingListViewController.self)) as? BreakingListViewController else { return }

    let viewModel = BreakingListViewModel()
    viewModel.delegate = self
    vc.viewModel = viewModel
    presenter.pushViewController(vc, animated: true)
  }
  
  fileprivate func setupReachability() {
    do {
      let reachability = try Reachability()
      self.connectivityHandler = ConnectivityHandler(reachability: reachability)
      self.connectivityHandler?.addListener(listener: self)
      self.connectivityHandler?.startNotifier()
      
    } catch {
      fatalError("Not initiated reachability")
    }
  }

}

extension ApplicationCoordinator: BreakingListViewModelCoordinatorDelegate {
  func BreakingListViewModelDidSelect(_ viewModel: BreakingListViewModel, character: Character) {
    guard let vc = storyBoard.instantiateViewController(withIdentifier: String(describing: BreakingBadDetailViewController.self)) as? BreakingBadDetailViewController else { return }


    let viewModel = BreakingBadDetailViewModel()
    viewModel.character.value = character
    vc.viewModel = viewModel
    presenter.pushViewController(vc, animated: true)
  }
}

extension ApplicationCoordinator : ConnectivityListener {
    func ConnectivityStatusDidChanged(_ connectionChangeEvent: ConnectionChangeEvent) {
        if connectionChangeEvent == .reEstablished {
            startBreakingList()
        }
    }
}
