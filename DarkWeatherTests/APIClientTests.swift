//
//  APIClientTests.swift
//  DarkWeatherTests
//
//  Created by Aleksander Popek on 02/12/2020.
//

import XCTest
@testable import DarkWeather

class APIClientTests: XCTestCase, MockedWeather {

    let failingJSON = "{]"
    let apiClient = APIClient()

    func testSerializedJSONSucess() {
        /// Given
        guard let jsonData: Data = mockedWeatherJSON.data(using: .utf8) else {
            fatalError("Cannot create data from string")
        }
        let error: Error? = nil

        /// When
        let result = apiClient.serializedJSON(with: jsonData, error: error) as Result<Weather>

        /// Then
        switch result {
        case .success(let response):
            XCTAssertEqual(2, response.hourly.data.count)
            XCTAssertEqual(2, response.daily.data.count)
        case .failure:
            XCTFail("testSerializedJSONSucess failed")
        }
    }

    func testSerializedJSONFailureDecodingError() {
        /// Given
        guard let jsonData: Data = failingJSON.data(using: .utf8) else {
            fatalError("Cannot create data from string")
        }
        let error: Error? = nil

        /// When
        let result = apiClient.serializedJSON(with: jsonData, error: error) as Result<Weather>

        /// Then
        switch result {
        case .success:
            XCTFail("testSerializedJSONFailureDecodingError failed")
        case .failure(let error):
            XCTAssertEqual(error, .decodingError)
        }
    }

    func testSerializedJSONFailureNoDataError() {
        /// Given
        let jsonData: Data? = nil
        let error: Error? = nil

        /// When
        let result = apiClient.serializedJSON(with: jsonData, error: error) as Result<Weather>

        /// Then
        switch result {
        case .success:
            XCTFail("testSerializedJSONFailureNoDataError failed")
        case .failure(let error):
            XCTAssertEqual(error, .noDataError)
        }
    }

    func testSerializedJSONFailureNetworkError() {
        /// Given
        let jsonData: Data? = nil
        let error: Error? = MockedError()

        /// When
        let result = apiClient.serializedJSON(with: jsonData, error: error) as Result<Weather>

        /// Then
        switch result {
        case .success:
            XCTFail("testSerializedJSONFailureNetworkError failed")
        case .failure(let error):
            XCTAssertEqual(error, .networkError)
        }
    }

    func testRequest() {
        /// Given
        guard let jsonData: Data = mockedWeatherJSON.data(using: .utf8) else {
            fatalError("Cannot create data from string")
        }
        let error: Error? = nil

        let apiClient: APIClient = APIClient()
        let mockedURLSession = MockedURLSession(data: jsonData, urlResponse: nil, error: error)
        var weatherResult: Result<Weather>?

        /// When
        let expectation = XCTestExpectation(description: "load weather")
        apiClient.request(
            target: .getWeather(
                latitude: 1.0,
                longitude: -1.0
            ),
            type: Weather.self,
            session: mockedURLSession
        ) { (result) in
            weatherResult = result
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)

        /// Then
        XCTAssertNotNil(weatherResult)
        switch weatherResult {
        case .success(let weather):
            XCTAssertEqual(2, weather.hourly.data.count)
            XCTAssertEqual(2, weather.daily.data.count)
        default:
            XCTFail("testRequest failed")
        }
    }

    func testAPIErrorMessageGetter() {
        XCTAssertEqual(APIError.decodingError.message, "Decoding error")
        XCTAssertEqual(APIError.networkError.message, "Network error")
        XCTAssertEqual(APIError.noDataError.message, "No data error")
    }
}
