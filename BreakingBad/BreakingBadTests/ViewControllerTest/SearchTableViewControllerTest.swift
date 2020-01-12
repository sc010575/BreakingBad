//
//  SearchTableViewControllerTest.swift
//  BreakingBadTests
//
//  Created by Suman Chatterjee on 12/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Quick
import Nimble

@testable import BreakingBad

class SearchTableViewControllerTest: QuickSpec {
  override func spec() {
    describe("SearchTableViewController tests") {
      var viewControllerOnTest: SearchTableViewController?
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      context("When SearchTableViewController is launched with a viewModel") {

        beforeEach {
          viewControllerOnTest = storyboard.instantiateViewController(withIdentifier: "SearchTableViewController") as? SearchTableViewController
          let viewModel = SearchViewModelMock()
          let cellViewModels = [
            BreakingListCellViewModel(name: "First Name", imageUrl: "http://firstUrl.com", charId: 1),
            BreakingListCellViewModel(name: "2nd Name", imageUrl: "http://2ndUrl.com", charId: 2),
            BreakingListCellViewModel(name: "3rd Name", imageUrl: "http://3rdtUrl.com", charId: 3),
            BreakingListCellViewModel(name: "4th Name", imageUrl: "http://4thUrl.com", charId: 4), BreakingListCellViewModel(name: "5th Name", imageUrl: "http://5thUrl.com", charId: 1),
            BreakingListCellViewModel(name: "6th Name", imageUrl: "http://6thUrl.com", charId: 1)]
          viewModel.searchCharacter.value = cellViewModels
          viewControllerOnTest?.viewModel = viewModel
          viewControllerOnTest?.preloadView()
        }
        afterEach {
          let (_, tearDown) = (viewControllerOnTest?.appearInWindowTearDown())!
          do { tearDown() }
        }
        it("Should have initiate an empty sercher controller during loading") {
          expect(viewControllerOnTest?.isSearchBarEmpty).to(beTrue())
        }
        it("should load all the cell models from the viewModel") {
          expect(viewControllerOnTest?.viewModel.searchCharacter.value.count).to(equal(6))
        }
        it("Should display name in the cell") {
          viewControllerOnTest?.tableView.reloadData()
          let cell = viewControllerOnTest?.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
          expect(cell?.textLabel?.text).toEventually(equal("First Name"))

          let anothercell = viewControllerOnTest?.tableView.cellForRow(at: IndexPath(row: 5, section: 0))
          expect(anothercell?.textLabel?.text).toEventually(equal("6th Name"))

        }
        it("Should return correct cellViewModel when user select a row") {
          viewControllerOnTest?.tableView.reloadData()
          let indexPath = IndexPath(row: 1, section: 0)
          let tableView = viewControllerOnTest?.tableView
          let viewModel = viewControllerOnTest?.viewModel as? SearchViewModelMock
          viewControllerOnTest?.tableView(tableView!, didSelectRowAt: indexPath)
          expect(viewModel?.didSelectRow).to(beTrue())
          expect(viewModel?.cellViewModelToTransfer?.name).to(equal("2nd Name"))
          expect(viewModel?.cellViewModelToTransfer?.charId).to(equal(2))
        }
        it("Should reload tableview with search result when search bar is active") {
          viewControllerOnTest?.filterContentForSearchText("First")
          expect(viewControllerOnTest?.filteredBadCharecters.count).toEventually(equal(1))
          let cell = viewControllerOnTest?.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
          expect(cell?.textLabel?.text).toEventually(equal("First Name"))
        }
      }
    }
  }
}


