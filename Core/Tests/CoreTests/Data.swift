//
//  File.swift
//  
//
//  Created by Darot on 27/09/2022.
//
import Core
import Foundation
struct DataFile {
    func createData() -> WeatherRealm {
        let weather = WeatherRealm()
        let location = LocationRealm()
        location.name = "London"
        weather.location = location
        weather.current = .init()
        weather.forecast = .init()
        return weather
    }
}
