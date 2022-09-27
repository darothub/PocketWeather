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
    
    public func makeRequest<T: Codable>(parameters: [String: Any], onCompletion: @escaping (Result<T, NetworkError>) -> Void) {
        request(parameters: parameters)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .failure(let error):
                    onCompletion(.failure(.networkError(error.localizedDescription)))
                case .success(let response):
                    onCompletion(.success(response))
                }
            }
    }
}
