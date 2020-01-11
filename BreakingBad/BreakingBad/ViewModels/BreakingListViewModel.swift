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
  let charId: Int

  init(_ character: Character) {
    self.name = character.name
    self.imageUrl = character.img
    self.charId = character.charId
  }
}

protocol BreakingListViewModelUseCase {
  typealias ResultType = Result<[BreakingListCellViewModel], AppError>
  var controllerTitle: String { get }
  var delegate: BreakingListViewModelCoordinatorDelegate? { get set }
  func fetchBadCharacters(completion: @escaping(ResultType) -> Void)
  func itemAtIndexPath(_ index: Int)
  func fileterCharectersByAppearance(_ appearance: [Int]) -> [BreakingListCellViewModel]
  func loadAllCharecters() -> [BreakingListCellViewModel]

}

protocol BreakingListViewModelCoordinatorDelegate: class
{
  func BreakingListViewModelDidSelect(_ viewModel: BreakingListViewModel, character: Character)
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

  func itemAtIndexPath(_ charId: Int) {
    if let delegate = delegate {
      let charecters = characters.filter { $0.charId == charId }
      if let charecter = charecters.first {
        delegate.BreakingListViewModelDidSelect(self, character: charecter)
      }
    }
  }

  func fileterCharectersByAppearance(_ appearance: [Int]) -> [BreakingListCellViewModel] {
    let appearanceString = appearance.map{ String($0)}.joined(separator: "-")
    var resultCharecters = [Character]()
    characters.forEach { (character) in
      let appearance = character.appearance.map{String($0)}.joined(separator: "-")
      if appearance == appearanceString {
        resultCharecters.append(character)
      }
    }
    let cellViewModels = resultCharecters.map { BreakingListCellViewModel($0) }
    return cellViewModels
  }

  func loadAllCharecters() -> [BreakingListCellViewModel] {
    let cellViewModels = characters.map { BreakingListCellViewModel($0) }
    return cellViewModels
  }
}
