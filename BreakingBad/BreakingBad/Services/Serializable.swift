//
//  Serializable.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 09/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation

// Protocol for Serialization
protocol Serializable {
    typealias ResultType = Result<Model,AppError>
    associatedtype Model
    static func parse(data:Data) ->ResultType
}

// Generic class for Serialize - Can be able to parse any model
final class Serialize<T:Decodable> : Serializable {
    typealias Model = T
    
    static func parse(data: Data) -> Result<T, AppError> {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let resultModel = try decoder.decode(Model.self, from: data)
            return .success(resultModel)
            
        }catch  {
            return .failure(.jsonError(message: "Json parsing error"))
        }
    }
}
