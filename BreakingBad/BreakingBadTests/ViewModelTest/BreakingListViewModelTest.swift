//
//  BreakingListViewModelTest.swift
//  BreakingBadTests
//
//  Created by Suman Chatterjee on 10/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import BreakingBad

class BreakingListViewModelTest: QuickSpec {
  override func spec() {
    describe("BreakingListViewModel Test") {
      context("when view model have a valid service") {
        var viewModel: BreakingListViewModelUseCase?
        var breakingBadApiService: BreakingBadApiService?
        var delegate: BreakingListViewModelCoordinatorDelegateMock?
        beforeEach {
          let network = NetworkMock()
          delegate = BreakingListViewModelCoordinatorDelegateMock()
          breakingBadApiService = BreakingBadApiService(network)
          viewModel = BreakingListViewModel(service: breakingBadApiService!)
          viewModel?.delegate = delegate
        }
        it("Should return a title") {
          expect(viewModel?.controllerTitle).to(equal("Breaking Bad"))
        }
        it("should create a valid BreakingListViewModel") {

          let expectation = self.expectation(description: "fatch resultData")
          viewModel?.fetchBadCharacters(completion: { (resultSuccess) in
            expectation.fulfill()
            switch resultSuccess {
            case .success(let testCellViewModels):
              expect(testCellViewModels.count).to(equal(7))
              let testCellViewModel = testCellViewModels[0]
              expect(testCellViewModel.name).to(equal("Jesse Pinkman"))
              expect(testCellViewModel.imageUrl).to(equal("https://url.220px-Jesse_Pinkman2.jpg"))
            default:
              break
            }
          })
          self.waitForExpectations(timeout: 1, handler: nil)
        }
        it("should  show a new filtered list when user filtered the appearance") {

          let expectation = self.expectation(description: "fatch resultData")
          viewModel?.fetchBadCharacters(completion: { (resultSuccess) in
            expectation.fulfill()
            switch resultSuccess {
            case .success(_):
              let charecters = viewModel?.fileterCharectersByAppearance([2, 3, 4])
              expect(charecters?.count).to(equal(2))

              //Another filter
              let anotherCharecters = viewModel?.fileterCharectersByAppearance([1, 2, 3])
              expect(anotherCharecters?.count).to(equal(1))
            default:
              break
            }
          })
          self.waitForExpectations(timeout: 1, handler: nil)

        }

        it("Should called BreakingListVieewModelCoordinatorDelegate when user pass a charId through itemAtIndexPath") {
          let expectation = self.expectation(description: "fatch resultData")
          viewModel?.fetchBadCharacters(completion: { (resultSuccess) in
            expectation.fulfill()
            switch resultSuccess {
            case .success(_):
              viewModel?.itemAtIndexPath(2)
              let delegate = viewModel?.delegate as? BreakingListViewModelCoordinatorDelegateMock
              expect(delegate?.spyDidSelectCalled).to(beTrue())
              expect(delegate?.charecterToTest?.name).to(equal("Jesse Pinkman"))
            default:
              break
            }
          })
          self.waitForExpectations(timeout: 1, handler: nil)

        }
        it("should called BreakingListSearchButtonDidSelected when serch will perform") {

          let expectation = self.expectation(description: "fatch resultData")
          viewModel?.fetchBadCharacters(completion: { (resultSuccess) in
            expectation.fulfill()
            switch resultSuccess {
            case .success(let testCellViewModels):
              let cellViewModelForSearch = testCellViewModels.first
              viewModel?.performSearch(cellViewModels: [cellViewModelForSearch!])
              let delegate = viewModel?.delegate as? BreakingListViewModelCoordinatorDelegateMock
              expect(delegate?.spyButtonDidSelectedCalled).to(beTrue())
              expect(delegate?.cellViewModelToTest?.name).to(equal("Jesse Pinkman"))
            default:
              break
            }
          })
          self.waitForExpectations(timeout: 1, handler: nil)
        }
      }
    }
  }
}

