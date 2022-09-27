//
//  File.swift
//  
//
//  Created by Darot on 27/09/2022.
//

import Core
import Foundation

class FakeApiService: ApiServices {
    public var apiCount = 0
    public init(){}

    public func makeRequest<T: Codable>(parameters: [String: Any], onCompletion: @escaping (Result<T, NetworkError>) -> Void) {
        apiCount += 1
        let data = DataFile()
        let weather = data.createData()
        onCompletion(.success(weather as! T))
    }
}
