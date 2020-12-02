//
//  APIClientProtocol.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import Foundation

protocol APIClientProtocol {
    func request<T:Decodable>(
        target: APIService,
        type: T.Type,
        session: URLSession,
        completion: @escaping (Result<T>) -> Void
    )
}

extension APIClientProtocol {
    /// Used to allow default value in protocol
    func request<T:Decodable>(
        target: APIService,
        type: T.Type,
        session: URLSession = URLSession(configuration: .default),
        completion: @escaping (Result<T>) -> Void
    ) {
        return request(target: target, type: type, session: session, completion: completion)
    }
}
