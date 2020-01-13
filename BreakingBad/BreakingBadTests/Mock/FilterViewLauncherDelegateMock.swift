//
//  FilterViewLauncherDelegateMock.swift
//  BreakingBadTests
//
//  Created by Suman Chatterjee on 13/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation
@testable import BreakingBad

class FilterViewLauncherDelegateMock: FilterViewLauncherDelegate{
  var filterViewLauncherDelegateCalled = false
  var value = [Int]()
  
  func filterViewLauncherDelegate(_ launcher: FilterViewLauncher, appearance: [Int]) {
    filterViewLauncherDelegateCalled = true
    value = appearance
  }
}
