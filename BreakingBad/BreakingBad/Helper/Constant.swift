//
//  Constant.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 13/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation

enum Constant {
  enum QueryType: String {
    case gists
    case file = "sc010575/feb733f8c6d6c38b9db4208fb7791567"
    case none
  }

  static let api = "api/characters"

  static var baseURL: URL? {

    if isUnitTest {
      return URL(string: "http://localhost:8088")
    }

    return URL(string: "https://breakingbadapi.com")
  }

  static var isUnitTest: Bool {
    #if targetEnvironment(simulator)
      if let _ = NSClassFromString("XCTest") {
        return true
      }
    #endif
    return false
  }
}
