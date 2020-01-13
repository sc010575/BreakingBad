//
//  BreakingBadApiService.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 09/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation

protocol BreakingBadApiServiceUseCase {
  typealias ResulType = Result<[Character], AppError>
  func retrieveModel(completion: @escaping(ResulType) -> Void)
}

// Final class for  to fetch data from network and create a AppModel
// Send it as a Result type if successful else send a Result type failure with error
final class BreakingBadApiService: BreakingBadApiServiceUseCase {
  private let network: NetworkUseCase
  init(_ network: NetworkUseCase = Network()) {
    self.network = network
  }

  func retrieveModel(completion: @escaping (ResulType) -> Void) {
    guard let baseUrl = Constant.baseURL else { return completion(.failure(.dataError(message: "Url is not correct")))

    }
    self.network.send(url: baseUrl) { (networkResult) in
      DispatchQueue.global(qos: .userInitiated).async {
        var serviceResult: ResulType
        switch networkResult {
        case .success(let data):
          let modelDataResult: ResulType = Serialize.parse(data: data)
          switch modelDataResult {
          case .success(let appData):
            let filteredAppData = Character.filteredCharacter(appData).sorted (by: { $0.name < $1.name
            })
            serviceResult = .success(filteredAppData)
          case .failure(let error):
            serviceResult = .failure(error)
          }
        case .failure(let error):
          serviceResult = .failure(error)
        }
        DispatchQueue.main.async {
          completion(serviceResult)
        }
      }
    }
  }
}
