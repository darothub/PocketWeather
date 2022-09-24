//
//  File.swift
//  
//
//  Created by Darot on 22/09/2022.
//
import Combine
import Foundation
public class GetUserLocationUsecase {
    private let locationManager: LocationManager
    private var subscriptions = Set<AnyCancellable>()
    public init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }
    public func callAsFunction() async throws ->  String {
        locationManager.locality
    }
}
