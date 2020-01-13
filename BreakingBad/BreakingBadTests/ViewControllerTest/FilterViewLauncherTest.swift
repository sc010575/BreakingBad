//
//  FilterViewLauncherTest.swift
//  BreakingBadTests
//
//  Created by Suman Chatterjee on 13/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Quick
import Nimble
@testable import BreakingBad

class FilterViewLauncherTest: QuickSpec {
  
  override func spec() {
    describe("FilterViewLauncher tests") {
      let viewOnTest: FilterViewLauncher =  FilterViewLauncher()
      let delegate: FilterViewLauncherDelegateMock = FilterViewLauncherDelegateMock()
      context("When FilterViewLauncherTest is launched ") {
        beforeEach {
          viewOnTest.delegate = delegate
          viewOnTest.showFilterView()
        }
        it("Should initiate a background view and a tableView"){
          expect(viewOnTest.backgroundView).notTo(beNil())
          expect(viewOnTest.tableView).notTo(beNil())
        }
        it("Should have 5 items in the tableView"){
          expect(viewOnTest.tableView.numberOfRows(inSection: 0)).to(equal(5))
        }
        it("Should show correct title for each row"){
          let cell = viewOnTest.tableView(viewOnTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
          expect(cell.textLabel?.text).to(equal("Season appearance - 1"))
        }
        it("Should call the delegate method and pass the appearence lists to the delegate"){
          var indexPath = IndexPath(row: 1, section: 0)
          viewOnTest.tableView(viewOnTest.tableView, didSelectRowAt: indexPath)
          expect(delegate.filterViewLauncherDelegateCalled).to(beTrue())
          expect(delegate.value).to(equal([2]))
          indexPath = IndexPath(row: 2, section: 0)
          viewOnTest.tableView(viewOnTest.tableView, didSelectRowAt: indexPath)
          indexPath = IndexPath(row: 3, section: 0)
          viewOnTest.tableView(viewOnTest.tableView, didSelectRowAt: indexPath)
          expect(delegate.value).to(equal([2,3,4]))
        }
      }
    }
  }
}
