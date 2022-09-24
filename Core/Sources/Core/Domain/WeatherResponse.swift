//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Darot on 30/04/2022.
//

import Foundation


public struct WeatherResponse : Codable, Equatable {
    public static func == (lhs: WeatherResponse, rhs: WeatherResponse) -> Bool {
        return lhs.location.name == rhs.location.name
    }
    
    public let location: Locations
    public let current: Currents
    public let forecast: Forecasts
    
    enum CodingKeys: String, CodingKey {
        case location = "location"
        case current = "current"
        case forecast = "forecast"
    }
}

extension WeatherResponse {
    public init(weather:WeatherRealm){
        self.location = Locations(location: weather.location!)
        self.current = Currents(current: weather.current!)
        self.forecast = Forecasts(forecast: weather.forecast!)
    }
}


// MARK: - Current
public struct Currents: Codable {
    public let lastUpdatedEpoch: Int
    public let lastUpdated: String
    public let tempC: Double
    public let condition: Conditions
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case condition
    }
}

extension Currents {
    
    public init(current:CurrentRealm){
        self.lastUpdatedEpoch = Int(current.lastUpdatedEpoch)
        self.lastUpdated = current.lastUpdated
        self.tempC = current.tempC
        self.condition = Conditions(condition: current.condition!)
    }
}
public struct Conditions : Codable{
    public let text: String
    public let icon: String
    public let code: Int
}

extension Conditions {
    
    public init(condition: ConditionRealm){
        self.text = condition.text
        self.icon = condition.icon
        self.code = Int(condition.code)
    }
}

public struct Forecasts : Codable{
    public let forecastday: [Forecastdays]
}

extension Forecasts {
    
    public init(forecast: ForecastRealm){
        self.forecastday = forecast.forecastday.compactMap {
            let forecastdaydb = $0
            return Forecastdays(forecastdaydb: forecastdaydb )
        }
    }
}

public struct Forecastdays : Codable{
    public let date: String
    public let dateEpoch: Int
    public let day: Days
    public let astro: Astros
    public let hour: [Hours]
    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}

extension Forecastdays {
    
    public init(forecastdaydb:ForecastdayRealm){
        self.date = forecastdaydb.date
        self.dateEpoch = Int(forecastdaydb.dateEpoch)
        self.day = Days(daydb: (forecastdaydb.day)!)
        self.astro = Astros(astrodb: forecastdaydb.astro!)
        self.hour = forecastdaydb.hour.compactMap({Hours(hourdb: $0)})
    }
}
public struct Astros : Codable{
    public let sunrise: String
    public let sunset: String
    enum CodingKeys: String, CodingKey {
        case sunrise, sunset
    }
}
extension Astros {
    
    public init(astrodb:AstroRealm){
        self.sunrise = astrodb.sunrise
        self.sunset = astrodb.sunset
    }
}
public struct Days : Codable{
    public let avgtempC: Double
    public let condition: Conditions
    
    enum CodingKeys: String, CodingKey {
        case avgtempC = "avgtemp_c"
        case condition
    }
}
extension Days {
    
    public init(daydb:DayRealm){
        self.avgtempC = daydb.avgtempC
        self.condition = Conditions(condition: daydb.condition!)
    }
}
public struct Hours : Codable{
    public let timeEpoch: Int
    public let tempC: Double
    public let condition: Conditions
    public let windMph: Double
    public let pressureIn: Double
    public let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case tempC = "temp_c"
        case condition
        case windMph = "wind_mph"
        case pressureIn = "pressure_in"
        case humidity
    }
}

extension Hours {
    
    public init(hourdb:HourRealm){
        self.timeEpoch = Int(hourdb.timeEpoch)
        self.tempC = hourdb.tempC
        self.condition = Conditions(condition:hourdb.condition!)
        self.windMph = hourdb.windMph
        self.pressureIn = hourdb.pressureIn
        self.humidity = Int(hourdb.humidity)
    }
}

public struct Locations : Codable{
    public let name: String
    public let region: String
    public let country: String
    public let lat: Double
    public let lon: Double
    public let localtimeEpoch: Int
    public let localtime: String
    
    enum CodingKeys: String, CodingKey {
            case name, region, country, lat, lon
            case localtimeEpoch = "localtime_epoch"
            case localtime
    }

}

extension Locations {
    
    public init(location:LocationRealm){
        self.name = location.name
        self.region = location.region
        self.country = location.country
        self.lat = location.lat
        self.lon = location.lon
        self.localtimeEpoch = Int(location.localtimeEpoch)
        self.localtime = location.localtime
    }

}
