//
//  LocalWeatherRepoImpl.swift
//  WeatherApp
//
//  Created by Darot on 15/05/2022.
//
import Combine
import Foundation
import RealmSwift
public class LocalWeatherRepositoryImpl : LocalRepository {
    @ObservedResults(WeatherRealm.self) private var weatherRealm
    
    public init(){}
    public func getLocalWeather(q query: String, days: Int) async throws -> WeatherRealm? {
        try await withCheckedThrowingContinuation { continuation in
            let data = $weatherRealm.wrappedValue.first { weather in
                weather.location?.name == query || weather.location?.country == query
            }
            continuation.resume(returning: data)
        }
  
    }
    public func saveWeatherForecast(weather: WeatherRealm){
        if (weather.location != nil && weather.current != nil && weather.forecast != nil){
            do {
                let realm = try Realm()
                try realm.write({
                    realm.add(weather)
                })
            } catch {
                print("RealmError \(error.localizedDescription)")
            }
        }
    }
}
