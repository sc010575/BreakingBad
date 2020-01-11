//
//  ConnectivityHandler.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 11/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation
import Reachability

enum ConnectionType {
  case wifi
  case cellular
  case offline
}

enum ConnectionChangeEvent {
  case reEstablished
  case other
}

protocol ConnectivityListener: class {
  func ConnectivityStatusDidChanged(_ connectionChangeEvent: ConnectionChangeEvent)
}

class ConnectivityHandler: ErrorTrigger {
  private var reachability: Reachability?
  private let notificationCenter: NotificationCenter

  init(reachability: Reachability,
    notificationCenter: NotificationCenter = NotificationCenter.default) {
    self.reachability = reachability
    self.notificationCenter = notificationCenter
  }

  var listeners = [ConnectivityListener]()
  private var previousConnectionType: ConnectionType = .offline
  private var currentConnecType: ConnectionType = .offline


  deinit {
    reachability?.stopNotifier()
  }

  var connectionType: ConnectionType {
    guard let reachability = reachability else { return .offline }
    switch reachability.connection {
    case .wifi:
      return .wifi
    case .cellular:
      return .cellular
    case .none, .unavailable:
      return .offline
    }
  }
  func addListener(listener: ConnectivityListener) {
    listeners.append(listener)
  }

  func removeListener(listener: ConnectivityListener) {
    listeners = listeners.filter { $0 !== listener }
  }

  func startNotifier() {
    reachability?.whenUnreachable = { _ in
      self.displayErrorMessage(error: ErrorMessage.fallbackLostConnectionError)
      self.previousConnectionType = .offline
    }
    notificationCenter.addObserver(
      self,
      selector: #selector(reachabilityChanged(_:)),
      name: .reachabilityChanged,
      object: reachability
    )
    try? reachability?.startNotifier()
  }

  @objc func reachabilityChanged(_ note: Notification) {
    guard let reachability = note.object as? Reachability else { return }
    self.reachability = reachability
    currentConnecType = connectionType
    if currentConnecType != previousConnectionType {
      previousConnectionType = currentConnecType
      self.listeners.forEach {
        $0.ConnectivityStatusDidChanged(.reEstablished)
      }
    }
  }
}
