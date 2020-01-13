//
//  Network.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 09/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation

enum AppError: Error {
  case networkError(message: String)
  case dataError(message: String)
  case jsonError(message: String)
}


protocol NetworkUseCase {
  typealias ResultType = Result<Data, AppError>
  func send(url: URL, completion: @escaping (ResultType) -> Void)
}

final class Network: NetworkUseCase {
  func send(url: URL, completion: @escaping (ResultType) -> Void) {
    let finalUrl = url.appendingPathComponent(Constant.api)
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    let task = session.dataTask(with: finalUrl) { (data, response, error) in
      var result: ResultType
      if let error = error {
        result = .failure(.networkError(message: error.localizedDescription))
      } else {

        if let httpResponse = response as? HTTPURLResponse, let data = data,
          200..<299 ~= httpResponse.statusCode {
          result = .success(data)
        } else {
          result = .failure(.dataError(message: "Data/Server error"))
        }
      }

      DispatchQueue.main.async {
        completion(result)
      }

    }
    task.resume()
  }
}


