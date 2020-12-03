//
//  MainViewModelTests.swift
//  DarkWeatherTests
//
//  Created by Aleksander Popek on 01/12/2020.
//

import XCTest
import CoreLocation
@testable import DarkWeather

class MainViewModelTests: XCTestCase, MockedWeather {

    var sut: MainViewModel!
    var mockedAPIClient: MockedAPIClient<Weather>!

    override func setUp() {
        super.setUp()

        mockedAPIClient = MockedAPIClient()
        sut = MainViewModel(apiClient: mockedAPIClient)
    }

    override func tearDown() {
        mockedAPIClient = nil
        sut = nil

        super.tearDown()
    }

    func testDidSetWeather() {
        /// Given
        sut.weather = mockedWeather

        /// When
        let items = sut.items

        /// Then
        XCTAssertNotNil(items)
        XCTAssertEqual(3, items.count)
        XCTAssertEqual(.temperature, items[0].type)
        XCTAssertEqual(.daily, items[1].type)
        XCTAssertEqual(.daily, items[2].type)
    }

    func testLoadWeatherWithNoCoordinates() {
        /// Given
        mockedAPIClient.data = mockedWeather

        /// When
        let expectation = XCTestExpectation(description: "load weather")
        sut.loadWeather {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)

        /// Then
        XCTAssertNil(sut.weather)
    }

    func testLoadWeather() {
        /// Given
        mockedAPIClient.data = mockedWeather
        sut.location = CLLocation(latitude: 1.0, longitude: -1.0)

        /// When
        let expectation = XCTestExpectation(description: "load weather")
        sut.loadWeather {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)

        /// Then
        XCTAssertNotNil(sut.weather)
        XCTAssertEqual(3, sut.items.count)
        XCTAssertEqual(.temperature, sut.items[0].type)
        XCTAssertEqual(.daily, sut.items[1].type)
        XCTAssertEqual(.daily, sut.items[2].type)
    }

    func testLoadWeatherFailure() {
        /// Given
        mockedAPIClient.forcedError = .noDataError
        sut.location = CLLocation(latitude: 1.0, longitude: -1.0)

        /// When
        let expectation = XCTestExpectation(description: "load weather")
        sut.loadWeather {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)

        /// Then
        XCTAssertNil(sut.weather)
        XCTAssertEqual(1, sut.items.count)
        XCTAssertEqual(.error, sut.items[0].type)
        XCTAssertEqual(sut.error, .noDataError)
    }
}
