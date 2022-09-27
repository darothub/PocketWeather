//
//  GetWeatherForecast.swift
//  WeatherApp
//
//  Created by Darot on 30/04/2022.
//
import Foundation
public class GetWeatherForecastUsecase {
    let localRepository: LocalRepository
    let remoteRepository: RemoteRepository
    
    public init(localRepository: LocalRepository, remoteRepository: RemoteRepository) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }
    
    public func callAsFunction(parameters: [String : Any]) async throws -> WeatherRealm {
        let q = parameters["q"] as! String
        let days = parameters["days"] as! Int
        guard let forecast = try await localRepository.getLocalWeather(q: q, days: days) else {
            let remoteData = try await remoteRepository.getWeatherData(parameters: parameters)
            DispatchQueue.main.async { [unowned self] in
                localRepository.saveWeatherForecast(weather: remoteData)
            }
            return remoteData
        }
        return forecast
    }
}

