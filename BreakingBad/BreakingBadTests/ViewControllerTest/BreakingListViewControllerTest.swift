//
//  BreakingListViewControllerTest.swift
//  BreakingBadTests
//
//  Created by Suman Chatterjee on 11/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import BreakingBad

class BreakingListViewControllerTest: QuickSpec {
  override func spec() {
    describe("BreakingListViewController tests") {
      var viewControllerOnTest: BreakingListViewController?
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      context("When BreakingListViewController is launched with a view model") {

        beforeEach {
          viewControllerOnTest = storyboard.instantiateViewController(withIdentifier: "BreakingListViewController") as? BreakingListViewController

          let network = NetworkMock()
          let breakingBadApiService = BreakingBadApiService(network)
          let viewModel = BreakingListViewModel(service: breakingBadApiService)
          viewControllerOnTest?.viewModel = viewModel
          viewControllerOnTest?.preloadView()
        }
        afterEach {
          let (_, tearDown) = (viewControllerOnTest?.appearInWindowTearDown())!
          do { tearDown() }
        }
        it("should have atleast filter button on the navigation bar") {
          expect(viewControllerOnTest?.navigationItem.rightBarButtonItems?.count).to(equal(2))
        }
        it("should initiate a collection view") {
          expect(viewControllerOnTest?.collectionView).notTo(beNil())
        }
        it("Should show a title on the navigation bar") {
          expect(viewControllerOnTest?.title).to(equal("Breaking Bad"))
        }
        it("should populate the cell viewmodel list") {
          expect(viewControllerOnTest?.exposePrivateBadCharecters().count).toEventually(equal(7))
          let cellViewModelToTest = viewControllerOnTest?.exposePrivateBadCharecters()[0]
          expect(cellViewModelToTest?.name).toEventually(equal("Jesse Pinkman"))
        }
      }
    }
  }
}
