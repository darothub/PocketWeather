//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Darot on 02/05/2022.
//
import CoreLocation
import Foundation
import MapKit
import Combine
public class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published public var locality:String = ""
    let geocoder = CLGeocoder()
    
    public static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    
    public override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }

    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        geocoder.reverseGeocodeLocation(location, completionHandler: {[unowned self] placemarks, error in
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            // City
            if let city = placeMark.locality {
//                print("city \(city)")
                locality = city
                print("Locality \(city)")
            }
        })
    }
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
          case .restricted, .denied:
             print("Denied")
             break
          case .authorizedWhenInUse, .authorizedAlways:
            print("enabled")
            locationManager.startUpdatingLocation()
             break
          case .notDetermined:
             break
        @unknown default:
            fatalError()
        }
    }
}

