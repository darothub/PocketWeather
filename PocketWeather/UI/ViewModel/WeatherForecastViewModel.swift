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
    @Published var forecast: WeatherRealm!
    @Published var uiModel: UIModel = UIModel.nothing
    @Published var currentWeatherUIModel: UIModel = UIModel.nothing
    @Published var dailyForecastUIModel: UIModel = UIModel.nothing
    @Published var hourlyForecastUIModel: UIModel = UIModel.nothing
    @Published var locality = ""
    @Published public var data:WeatherRealm!
    private var getWeatherForecastUsecase: GetWeatherForecastUsecase
    let geocoder = CLGeocoder()
    private var subscriptions = Set<AnyCancellable>()
    
    private let locationManager = CLLocationManager()
    
    public init(
        getWeatherForecastUsecase: GetWeatherForecastUsecase
    ) {
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
                    let parameters:[String: Any] = [
                        "key" : Constants.apikey,
                        "q" : location,
                        "days" : 7
                    ]
                    forecast = try await getWeatherForecastUsecase(parameters: parameters)
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
            if let city = placeMark.locality {
                if locality.isEmpty {
                    locality = city
                    getForecast() 
                }
            }
        })
    }
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        uiModel = UIModel.location
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
