//
//  GetWeatherForecast.swift
//  WeatherApp
//
//  Created by Darot on 30/04/2022.
//

public class GetWeatherForecastUsecase {
    let localRepository: LocalRepository
    let remoteRepository: RemoteRepository
    
    public init(localRepository: LocalRepository, remoteRepository: RemoteRepository) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }
    
    public func callAsFunction(q: String, days: Int) async throws -> WeatherRealm {
        guard let forecast = try await localRepository.getLocalWeather(q: q, days: days) else {
            let remoteData = try await remoteRepository.getWeatherData(q: q, days: days)
            localRepository.saveWeatherForecast(weather: remoteData)
            return remoteData
        }
        return forecast
    }
}

