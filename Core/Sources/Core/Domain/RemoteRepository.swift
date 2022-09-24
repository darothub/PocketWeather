//
//  RemoteRepository.swift
//  WeatherApp
//
//  Created by Darot on 09/05/2022.
//

import Alamofire
import Foundation

public protocol RemoteRepository {
    func getWeatherData(q: String, days:Int) async throws -> WeatherRealm
}


public class RemoteRepositoryImpl : RemoteRepository {
    private var apiService: ApiServices
    
    public init(apiService: ApiServices) {
        self.apiService = apiService
    }
    
    public func getWeatherData(q: String, days:Int) async throws -> WeatherRealm {
        try await withCheckedThrowingContinuation { continuation in
            apiService.fetchWeatherForecast(in: q, for: days)
                .responseJSON(completionHandler: { resp in
                    print("Response\(resp)")
                })
                .responseDecodable(of: WeatherRealm.self){ res in
                    switch res.result {
                    case let .failure(error):
                        continuation.resume(throwing: error)
                    case let .success(response):
                        continuation.resume(returning: response)
                    }
                    
                }
        }
    }
}
