//
//  MockedURLSessionDataTask.swift
//  DarkWeatherTests
//
//  Created by Aleksander Popek on 02/12/2020.
//

import Foundation

class MockedURLSessionDataTask: URLSessionDataTask {

    private let data: Data?
    private let urlResponse: URLResponse?

    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)!

    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
    }

    override func resume() {
        DispatchQueue.main.async {
            self.completionHandler(self.data, self.urlResponse, self.error)
        }
    }
}
