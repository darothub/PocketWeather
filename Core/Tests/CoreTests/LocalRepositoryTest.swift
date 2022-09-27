//
//  LocalRepositoryTest.swift
//  
//
//  Created by Darot on 27/09/2022.
//

import XCTest
import Core

class LocalRepositoryTest: XCTestCase {
    var repository: LocalRepository!
    var data: DataFile!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        repository = LocalWeatherRepositoryImpl()
        data = DataFile()
        let weather = data.createData()
        repository.saveWeatherForecast(weather: weather)
    }
    func testSaveWeatherForecast() async throws {
        let expected = data.createData().location?.name
        let actual = try await repository.getLocalWeather(q: "London", days: 7)?.location?.name
        XCTAssertEqual(actual, expected, "Expected \(expected) but found \(String(describing: actual))")
    }
}
