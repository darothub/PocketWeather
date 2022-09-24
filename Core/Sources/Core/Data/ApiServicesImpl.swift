//
//  FetchDataFromRemote.swift
//  WeatherApp
//
//  Created by Darot on 30/04/2022.
//
import Alamofire
import Foundation
public class ApiServicesImpl : ApiServices {
    public init(){}
    public func fetchWeatherForecast(in q: String, for days:Int) -> DataRequest{
        let parameters:[String: Any] = [
            "key" : Constants.apikey,
            "q" : q,
            "days" : days
        ]
        let request = AF.request(Constants.baseUrl, method: .get, parameters: parameters)
        return request
    }
}
