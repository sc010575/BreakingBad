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
        beforeEach {
          let network = NetworkMock()
          breakingBadApiService = BreakingBadApiService(network)
          viewModel = BreakingListViewModel(service: breakingBadApiService!)
        }
        it("should create a valid BreakingListViewModel") {
          
          let extectation = self.expectation(description: "fatch jobs")
          viewModel?.fetchBadCharacters(completion: { (resultSuccess) in
              extectation.fulfill()
              switch resultSuccess {
              case .success(let testCellViewModels):
                expect(testCellViewModels.count).to(equal(4))
                let testCellViewModel = testCellViewModels[0]
                expect(testCellViewModel.name).to(equal("Jesse Pinkman"))
                expect(testCellViewModel.imageUrl).to(equal("https://url.220px-Jesse_Pinkman2.jpg"))
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

