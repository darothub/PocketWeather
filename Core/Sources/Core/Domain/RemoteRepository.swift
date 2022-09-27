//
//  RemoteRepository.swift
//  WeatherApp
//
//  Created by Darot on 09/05/2022.
//

import Alamofire
import Foundation
import XCTest

public protocol RemoteRepository {
    func getWeatherData(parameters: [String : Any]) async throws -> WeatherRealm
}


public class RemoteRepositoryImpl : RemoteRepository {
    private var apiService: ApiServices
    
    public init(apiService: ApiServices) {
        self.apiService = apiService
    }
    
    public func getWeatherData(parameters: [String : Any]) async throws -> WeatherRealm {
        try await withCheckedThrowingContinuation { continuation in
            apiService.makeRequest(parameters: parameters) { (result: Result<WeatherRealm, NetworkError>) in
                continuation.resume(with: result)
            }
        }
    }
}
