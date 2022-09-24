//
//  WeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by Darot on 30/04/2022.
//
import CoreLocation
import Core
import Combine
import Foundation
import MapKit
import SwiftUI
@MainActor
class WeatherForecastViewModel : NSObject, ObservableObject, CLLocationManagerDelegate  {
    @State private var lastQuery = UserDefaults.standard.string(forKey: Constant.LOCALITY)
    @Published var weatherResponse: WeatherResponse!
    @Published var forecast: WeatherRealm!
    @Published var uiModel: UIModel = UIModel.nothing
    @Published var currentWeatherUIModel: UIModel = UIModel.nothing
    @Published var dailyForecastUIModel: UIModel = UIModel.nothing
    @Published var hourlyForecastUIModel: UIModel = UIModel.nothing
    @Published var locality = ""
    @Published public var data:WeatherRealm!
    private var getUserLocationUsecase: GetUserLocationUsecase
    private var getWeatherForecastUsecase: GetWeatherForecastUsecase
    let geocoder = CLGeocoder()
    private var subscriptions = Set<AnyCancellable>()
    
    private let locationManager = CLLocationManager()
    
    public init(
        getUserLocationUsecase: GetUserLocationUsecase,
        getWeatherForecastUsecase: GetWeatherForecastUsecase
    ) {
        self.getUserLocationUsecase = getUserLocationUsecase
        self.getWeatherForecastUsecase = getWeatherForecastUsecase
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }
        
    public func getForecast()  {
        uiModel = UIModel.loading
        $locality.sink { [unowned self] location in
            Task {
                do {
                    forecast = try await getWeatherForecastUsecase(q: location, days: 7)
                    let currentWeatherContent = UIModel.ContentViewModel(data: forecast.current, message: "Successful")
                    currentWeatherUIModel = UIModel.content(currentWeatherContent)
                    let dailyWeatherContent = UIModel.ContentViewModel(data: forecast.forecast?.forecastday, message: "Successful")
                    dailyForecastUIModel = UIModel.content(dailyWeatherContent)
                    if let hours = forecast.forecast?.forecastday.first?.hour  {
                        let hourlyWeatherContent = UIModel.ContentViewModel(data: hours, message: "Successful")
                        hourlyForecastUIModel = UIModel.content(hourlyWeatherContent)
                    }
                    let content = UIModel.ContentViewModel(data: "forecast", message: "Successful")
                    uiModel = UIModel.content(content)
                }catch {
                    uiModel = UIModel.error(error.localizedDescription)
                }
            }
        }.store(in: &subscriptions)
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        guard let location = locations.last else { return }
        geocoder.reverseGeocodeLocation(location, completionHandler: {[unowned self] placemarks, error in
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            // City
            if let city = placeMark.locality {
                if locality.isEmpty {
                    locality = city
                    print("Locality \(city)")
                    getForecast() 
                }
            }
        })
    }
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        uiModel = UIModel.loading
        switch status {
        case .restricted, .denied:
            print("Denied")
            uiModel = UIModel.error("Location Permission denied")
            break
        case .authorizedWhenInUse, .authorizedAlways:
            print("enabled")
            locationManager.startUpdatingLocation()
            uiModel = UIModel.location
            break
        case .notDetermined:
            break
        @unknown default:
            fatalError()
        }
    }
}



enum Constant{
    static let LOCALITY = "locality"
}
