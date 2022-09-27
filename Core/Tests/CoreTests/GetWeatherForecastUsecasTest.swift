//
//  GetWeatherForecastUsecasTest.swift
//  
//
//  Created by Darot on 27/09/2022.
//


import Core
import RealmSwift
import XCTest
class GetWeatherForecastUsecasTest: XCTestCase {
    var apiServices: ApiServices!
    var remoteRepository: RemoteRepository!
    var localRepository: LocalRepository!
    var usecase: GetWeatherForecastUsecase!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        apiServices = FakeApiService()
        remoteRepository = RemoteRepositoryImpl(apiService: apiServices)
        localRepository = LocalWeatherRepositoryImpl()
        usecase = GetWeatherForecastUsecase(localRepository: localRepository, remoteRepository: remoteRepository)
    }
    
    func testGetWeatherForecastUsecase() async throws {
        let parameters:[String: Any] = [
            "key" : Constants.apikey,
            "q" : "London",
            "days" : 7
        ]
        let result = try await usecase(parameters: parameters)
        let expected = "London"
        let actual = result.location?.name
        XCTAssertEqual(actual, expected, "Expected \(expected) but found \(String(describing: actual))")
    }

}
