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
  var controllerTitle:String { get }
  var delegate: BreakingListViewModelCoordinatorDelegate? { get set }
  func fetchBadCharacters(completion: @escaping(ResultType) -> Void)
  func itemAtIndexPath(_ index:Int)
  func fileterCharectersByAppearance(_ appearance:[Int]) -> [Character]
}

protocol BreakingListViewModelCoordinatorDelegate: class
{
  func BreakingListViewModelDidSelect(_ viewModel: BreakingListViewModel, character:Character)
}

final class BreakingListViewModel: BreakingListViewModelUseCase {
  private let service: BreakingBadApiServiceUseCase
  var characters: [Character] = [Character]()
  weak var delegate: BreakingListViewModelCoordinatorDelegate?

  init(service: BreakingBadApiServiceUseCase = BreakingBadApiService()) {
    self.service = service
  }
  
  var controllerTitle = "Breaking Bad"

  func fetchBadCharacters(completion: @escaping(ResultType) -> Void) {
    service.retrieveModel { (results) in
      switch results {
      case .success(let models):
        let cellViewModels = models.map { BreakingListCellViewModel($0) }
        self.characters = models
        completion(.success(cellViewModels))

      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func itemAtIndexPath(_ index:Int) {
    if let delegate = delegate {
        let charecter = characters[index]
      delegate.BreakingListViewModelDidSelect(self, character: charecter)
    }
  }
  func fileterCharectersByAppearance(_ appearance:[Int]) -> [Character] {
    let appearanceReduce = appearance.reduce(0,+)
    var resultCharecters = [Character]()
    characters.forEach { (character) in
      if character.appearance.reduce(0,+) == appearanceReduce {
        resultCharecters.append(character)
      }
    }
    return resultCharecters
  }
}
