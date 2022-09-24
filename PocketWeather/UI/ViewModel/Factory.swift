//
//  ViewModelFactory.swift
//  WeatherApp
//
//  Created by Darot on 30/04/2022.
//

import Foundation
import Core

protocol Factory {
    static func createWFVM() -> WeatherForecastViewModel
}

class Dependencies {
    @MainActor
    static func createWFVM() -> WeatherForecastViewModel {
        return WeatherForecastViewModel(
            getUserLocationUsecase: createLocationUsecase(),
            getWeatherForecastUsecase: createWeatherForecastUsecase()
        )
    }
    static func createLocationUsecase() -> GetUserLocationUsecase {
        GetUserLocationUsecase(locationManager: .shared)
    }
    static func createWeatherForecastUsecase() -> GetWeatherForecastUsecase {
        GetWeatherForecastUsecase(
            localRepository: createLocalRepository(),
            remoteRepository: createRemoteRepository()
        )
    }
    static func createLocalRepository() -> LocalRepository {
        LocalWeatherRepositoryImpl()
    }
    static func createRemoteRepository() -> RemoteRepository {
        RemoteRepositoryImpl(apiService: createApiServices())
    }
    static func createApiServices() -> ApiServices {
        ApiServicesImpl()
    }
}


