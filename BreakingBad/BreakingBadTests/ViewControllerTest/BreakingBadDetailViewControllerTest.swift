//
//  BreakingBadDetailViewControllerTest.swift
//  BreakingBadTests
//
//  Created by Suman Chatterjee on 11/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Nimble
import Quick

@testable import BreakingBad


class BreakingBadDetailViewControllerTest: QuickSpec {
  override func spec() {
    describe("BreakingBadDetailViewController tests") {
      var viewControllerOnTest: BreakingBadDetailViewController?
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      context("When BreakingBadDetailViewController is launched with a view model") {

        beforeEach {
          viewControllerOnTest = storyboard.instantiateViewController(withIdentifier: "BreakingBadDetailViewController") as? BreakingBadDetailViewController
          let charecter = Character(charId: 1, name: "A name", occupation: ["Doctor","Other Profession"], img: "https://url.com", status: "alive", nickname: "A nickname", appearance: [1, 2, 4], category: "Breaking Bad")

          let viewModel = BreakingBadDetailViewModel()
          viewModel.character.value = charecter
          viewControllerOnTest?.viewModel = viewModel
          viewControllerOnTest?.preloadView()
        }
        afterEach {
          let (_, tearDown) = (viewControllerOnTest?.appearInWindowTearDown())!
          do { tearDown() }
        }

        it("Should show the right name and nicknamelabel") {
          expect(viewControllerOnTest?.nameLabel.text).to(equal("Name - A name"))
          expect(viewControllerOnTest?.nickNameLabel.text).to(equal("Best known as - A nickname"))
        }
        it("Should show the Occupation with a comma seperated string") {
          expect(viewControllerOnTest?.occupation.text).to(equal("Doctor,Other Profession"))
        }
        it("Should show the Appearance with a comma seperated string") {
          expect(viewControllerOnTest?.appearanceLabel.text).to(equal("1,2,4"))
        }
      }
    }
  }
}
