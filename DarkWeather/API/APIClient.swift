//
//  APIClient.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import Foundation

enum APIError: Error {
    case noDataError
    case networkError
    case decodingError

    var message: String {
        switch self {
        case .decodingError:
            return "Decoding error"
        case .networkError:
            return "Network error"
        case .noDataError:
            return "No data error"
        }
    }
}

enum Result<T> {
    case success(T)
    case failure(APIError)
}

/// API Client class. Requests should be made through this class only.
final class APIClient: APIClientProtocol {

    /// Designated request-making method.
    func request<T: Decodable>(
        target: APIService,
        type: T.Type,
        session: URLSession = URLSession(configuration: .default),
        completion: @escaping (Result<T>) -> Void) {

        let dataTask = session.dataTask(
            with: URL(target: target)
        ) { data, _, error in
            var result: Result<T>

            switch target {
            case .getWeather:
                result = self.serializedJSON(with: data, error: error)
            }

            DispatchQueue.main.async {
                completion(result)
            }
        }
        dataTask.resume()
    }
}

// MARK: - Private serialization methods

extension APIClient {
    /// Used to deserialize `JSON` from `Data` object passed in parameters
    func serializedJSON<T: Decodable>(with data: Data?, error: Error?) -> Result<T> {
        if error != nil { return .failure(.networkError) }
        guard let data = data else { return .failure(.noDataError) }
        do {
            let serializedValue = try JSONDecoder().decode(T.self, from: data)
            return .success(serializedValue)
        } catch {
            return .failure(.decodingError)
        }
    }
}
