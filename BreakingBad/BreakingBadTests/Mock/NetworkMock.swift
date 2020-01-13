//
//  NetworkMock.swift
//  BreakingBadTests
//
//  Created by Suman Chatterjee on 09/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation

@testable import BreakingBad

class NetworkMock: NetworkUseCase {
    func send(url: URL, completion: @escaping (ResultType) -> Void) {
        guard let modelToTestData = Fixture.getData("character") else { return }
        completion(.success(modelToTestData))
    }
}

