//
//  SearchViewModelMock.swift
//  BreakingBadTests
//
//  Created by Suman Chatterjee on 12/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation

@testable import BreakingBad

class SearchViewModelMock: SearchViewModelUseCase {
  
  weak var delegate: SearchViewModelCoordinatorDelegate?
  var searchCharacter: Observer<[BreakingListCellViewModel]> = Observer([BreakingListCellViewModel.emptyCellViewModel()])
  var didSelectRow = false
  var cellViewModelToTransfer: BreakingListCellViewModel?
  
  func onSelectRow(cellViewModel:BreakingListCellViewModel) {
    didSelectRow = true
    cellViewModelToTransfer = cellViewModel
  }
}
