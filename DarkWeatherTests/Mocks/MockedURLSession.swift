//
//  MockedURLSession.swift
//  DarkWeatherTests
//
//  Created by Aleksander Popek on 02/12/2020.
//

import Foundation

class MockedURLSession: URLSession {
    private let mockedTask: MockedURLSessionDataTask

    var cachedUrl: URL?

    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        mockedTask = MockedURLSessionDataTask(data: data, urlResponse: urlResponse, error: error)
    }

    override func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        cachedUrl = url
        mockedTask.completionHandler = completionHandler
        return mockedTask
    }
}
