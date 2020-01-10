//
//  BreakingListViewModel.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 09/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation

struct BreakingListCellViewModel {
  let name: String
  let imageUrl: String

  init(_ character: Character) {
    self.name = character.name
    self.imageUrl = character.img
  }
}

protocol BreakingListViewModelUseCase {
  typealias ResultType = Result<[BreakingListCellViewModel], AppError>
  func fetchBadCharacters(completion: @escaping(ResultType) -> Void)
}

class BreakingListViewModel: BreakingListViewModelUseCase {
  private let service: BreakingBadApiServiceUseCase

  init(service: BreakingBadApiServiceUseCase = BreakingBadApiService()) {
    self.service = service
  }

  func fetchBadCharacters(completion: @escaping(ResultType) -> Void) {
    service.retrieveModel { (results) in
      switch results {
      case .success(let models):
        let cellViewModels = models.map { BreakingListCellViewModel($0) }.sorted (by: { $0.name < $1.name
        })
        completion(.success(cellViewModels))

      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
