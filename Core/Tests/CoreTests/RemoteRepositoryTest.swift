//
//  RemoteRepositoryTest.swift
//  
//
//  Created by Darot on 27/09/2022.
//

import XCTest
import Core

class RemoteRepositoryTest: XCTestCase {
    var apiServices: ApiServices!
    var repository: RemoteRepository!
    override func setUpWithError() throws {
        apiServices = FakeApiService()
        repository = RemoteRepositoryImpl(apiService: apiServices)
    }

    func testGetWeatherData() async throws {
        let parameters:[String: Any] = [
            "key" : Constants.apikey,
            "q" : "Anywhere",
            "days" : 7
        ]
        let expected = try await repository.getWeatherData(parameters: parameters)
        XCTAssertNotNil(expected)
    }

}
