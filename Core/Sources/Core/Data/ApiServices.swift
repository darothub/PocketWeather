//
//  FetchWeather.swift
//  WeatherApp
//
//  Created by Darot on 30/04/2022.
//
import Alamofire
import Foundation
public protocol ApiServices {
    func fetchWeatherForecast(in q: String,  for days:Int) -> DataRequest
}


public enum Constants{
    public static let baseUrl = "https://api.weatherapi.com/v1/forecast.json"
    public static let apikey = "a3dcb83d3dca466c9a4155723220501"
    public static let imagePlaceHolderUrl = "//cdn.weatherapi.com/weather/64x64/day/176.png"
}
