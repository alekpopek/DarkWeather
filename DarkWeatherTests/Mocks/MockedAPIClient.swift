//
//  MockedAPIClient.swift
//  DarkWeatherTests
//
//  Created by Aleksander Popek on 02/12/2020.
//

import Foundation
@testable import DarkWeather

class MockedAPIClient<T:Decodable>: APIClientProtocol {
    
    var forcedError:APIError?
    var data:T? = nil

    func request<T:Decodable>(
        target: APIService,
        type: T.Type,
        session: URLSession,
        completion: @escaping (Result<T>) -> Void
    ) {
        if let error = forcedError {
            completion(.failure(error))
        } else {
            completion(.success(data as! T))
        }
    }
}
