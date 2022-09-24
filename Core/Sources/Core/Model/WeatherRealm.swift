//
//  WeatherRealm.swift
//  WeatherApp
//
//  Created by Darot on 12/05/2022.
//


import RealmSwift

public class WeatherRealm : Object, Codable, ObjectKeyIdentifiable {
    @Persisted public var location: LocationRealm?
    @Persisted public var current: CurrentRealm?
    @Persisted public var forecast: ForecastRealm?
    
    enum CodingKeys: String, CodingKey {
        case location = "location"
        case current = "current"
        case forecast = "forecast"
    }
}


public class LocationRealm : Object, Codable {
    @Persisted public var name: String = ""
    @Persisted public var region: String = ""
    @Persisted public var country: String = ""
    @Persisted public var lat: Double = 0
    @Persisted public var lon: Double = 0
    @Persisted public var localtimeEpoch: Int = 0
    @Persisted public var localtime: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}


public class CurrentRealm:Object, Codable {
    @Persisted public var lastUpdatedEpoch: Int = 0
    @Persisted public var lastUpdated: String = ""
    @Persisted public var tempC: Double = 0
    @Persisted public var condition: ConditionRealm?
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case condition
    }
}

public class ForecastRealm : Object, Codable {
    @Persisted public var forecastday = RealmSwift.List<ForecastdayRealm>()
}


public class ForecastdayRealm : Object, Codable, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var id: ObjectId
    @Persisted public var date: String = ""
    @Persisted public var dateEpoch: Int = 0
    @Persisted public var day: DayRealm?
    @Persisted public var astro: AstroRealm?
    @Persisted public var hour = RealmSwift.List<HourRealm>()
    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}

public class AstroRealm: Object, Codable {
    @Persisted public var sunrise: String = ""
    @Persisted public var sunset: String = ""
    enum CodingKeys: String, CodingKey {
        case sunrise, sunset
    }
}

public class DayRealm : Object, Codable {
    @Persisted public var avgtempC: Double = 0
    @Persisted public var condition: ConditionRealm?
    
    enum CodingKeys: String, CodingKey {
        case avgtempC = "avgtemp_c"
        case condition
    }
}

public class ConditionRealm : Object, Codable {
    @Persisted public var text: String
    @Persisted public var icon: String
    @Persisted public var code: Int
}

public class HourRealm : Object, Codable, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var id: ObjectId
    @Persisted public var timeEpoch: Int = 0
    @Persisted public var tempC: Double = 0
    @Persisted public var condition: ConditionRealm?
    @Persisted public var windMph: Double = 0
    @Persisted public var pressureIn: Double = 0
    @Persisted public var humidity: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case tempC = "temp_c"
        case condition
        case windMph = "wind_mph"
        case pressureIn = "pressure_in"
        case humidity
    }
}


protocol DataObject {
    var location: LocationRealm? {get set}
    var current: CurrentRealm? {get set}
    var forecast: ForecastRealm? {get set}
}
