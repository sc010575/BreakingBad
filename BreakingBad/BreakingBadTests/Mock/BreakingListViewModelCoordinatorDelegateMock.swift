//
//  BreakingListViewModelCoordinatorDelegateMock.swift
//  BreakingBadTests
//
//  Created by Suman Chatterjee on 13/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation
@testable import BreakingBad

class BreakingListViewModelCoordinatorDelegateMock: BreakingListViewModelCoordinatorDelegate {

  var spyDidSelectCalled = false
  var spyButtonDidSelectedCalled = false
  var charecterToTest: Character?
  var cellViewModelToTest:BreakingListCellViewModel?
  
  func BreakingListViewModelDidSelect(_ viewModel: BreakingListViewModel, character: Character) {
    spyDidSelectCalled = true
    charecterToTest = character
  }

  func BreakingListSearchButtonDidSelected(_ viewModel: BreakingListViewModel, cellViewModels: [BreakingListCellViewModel]) {
    spyButtonDidSelectedCalled = true
    cellViewModelToTest = cellViewModels.first
  }
}
