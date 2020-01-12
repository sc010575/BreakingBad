//
//  SearchViewModel.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 12/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation


protocol SearchViewModelUseCase {
  var searchCharacter:Observer<[BreakingListCellViewModel]> { get set }
  var delegate:SearchViewModelCoordinatorDelegate? { get }
  func onSelectRow(cellViewModel:BreakingListCellViewModel)
}

protocol SearchViewModelCoordinatorDelegate: class
{
  func searchViewModelDidSelect(_ viewModel: SearchViewModel, cellViewModel: BreakingListCellViewModel)
}


class SearchViewModel : SearchViewModelUseCase {
  weak var delegate: SearchViewModelCoordinatorDelegate?
  var searchCharacter: Observer<[BreakingListCellViewModel]> = Observer([BreakingListCellViewModel.emptyCellViewModel()])
  
  func onSelectRow(cellViewModel:BreakingListCellViewModel) {
    delegate?.searchViewModelDidSelect(self, cellViewModel: cellViewModel)
  }
}
