//
//  BreakingBadApiServiceTest.swift
//  BreakingBadTests
//
//  Created by Suman Chatterjee on 13/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Quick
import Nimble
@testable import BreakingBad

class BreakingBadApiServiceTest: QuickSpec {
  let server = MockServer()
  override func spec() {
    describe("BreakingBadApiService tests") {
      let breakingBadApiServiceOnTest = BreakingBadApiService()
      context("When BreakingBadApiService is launched and call retrieveModel") {
        afterEach {
          self.server.stop()
        }
        it("Should load the charecters") {
          self.server.respondToCharecterApiSuccess().start()
          let expectation = self.expectation(description: "fatch resultData")
          breakingBadApiServiceOnTest.retrieveModel { (results) in
            expectation.fulfill()
            switch results {
            case .success(let charecters):
              expect(charecters.count).to(equal(7))
            default:
              break
            }
          }
          self.waitForExpectations(timeout: 1, handler: nil)
        }
        it("should show an error message for an unsuccessful case") {
          self.server.respondToCharecterApiFailure().start()
          let expectation = self.expectation(description: "fatch resultData")
          breakingBadApiServiceOnTest.retrieveModel { (results) in
            expectation.fulfill()
            switch results {
            case .failure(let appArror):
              expect(appArror.localizedDescription).to(equal("The operation couldn’t be completed. (BreakingBad.AppError error 1.)"))
            default:
              break
            }
          }
          self.waitForExpectations(timeout: 1, handler: nil)

        }
      }
    }
  }
}
