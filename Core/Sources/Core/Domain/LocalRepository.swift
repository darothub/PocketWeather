//
//  LocalRepository.swift
//  WeatherApp
//
//  Created by Darot on 09/05/2022.
//

import Foundation
public protocol LocalRepository {
    func saveWeatherForecast(weather: WeatherRealm)
    func getLocalWeather(q query: String, days: Int) async throws -> WeatherRealm?
}
