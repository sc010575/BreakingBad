//
//  CharacterTest.swift
//  BreakingBadTests
//
//  Created by Suman Chatterjee on 09/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Quick
import Nimble

@testable import BreakingBad

class CharacterTest: QuickSpec {
  override func spec() {
    describe("BreakingBad model Test") {
      context("when valid data for Character model") {
        it("should parse and load the model properly") {
          let dataResult = Fixture.getData("character")
          typealias ResulType = Result<[Character], AppError>

          let modelToTest: ResulType = Serialize.parse(data: dataResult!)
          switch modelToTest {
          case .success(let results):
            expect(results.count).to(equal(6))
            let filteredModel = Character.filteredCharacter(results)
            expect(filteredModel.count).to(equal(4))
            let characterToTest = filteredModel[0]
            expect(characterToTest.name).to(equal("Walter White"))
            expect(characterToTest.img).to(equal("https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg"))
            expect(characterToTest.nickname).to(equal("Heisenberg"))
          default:
            break
          }
        }
      }
    }
    context("when an invalid data for Character model") {
      it("should not parse and send failure") {
        let dataResult = Fixture.getData("empty")
        typealias ResulType = Result<[Character], AppError>
        let modelToTest: ResulType = Serialize.parse(data: dataResult!)
        guard case .failure(let apperror) = modelToTest,
          case .jsonError(let message) = apperror else { return }

        expect(message).to(equal("Json parsing error"))
      }
    }
  }
}
