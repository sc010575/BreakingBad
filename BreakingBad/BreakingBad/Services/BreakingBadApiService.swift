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

// Final class for JobService to fetch data from network and create a AppModel
// Send it as a Result type if successful else send a Result type failure with error
final class BreakingBadApiService: BreakingBadApiServiceUseCase {
    private let network: NetworkUseCase
    init(_ network: NetworkUseCase = Network()) {
        self.network = network
    }
    
    func retrieveModel(completion: @escaping (ResulType) -> Void) {
        network.send(url: AppConstant.BaseUrl) { (networkResult) in
            var serviceResult: ResulType
            switch networkResult {
            case .success(let data):
                let modelDataResult: ResulType = Serialize.parse(data: data)
                switch modelDataResult {
                case .success(let appData):
                    serviceResult = .success(appData)
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
