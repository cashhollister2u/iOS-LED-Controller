//
//  NetworkManager.swift
//  LED Controller
//
//  Created by Cash Hollister on 5/17/24.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(from urlString: String, completion: @escaping (Result<(statusCode: Int, responseBody: String), Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.badResponse))
                return
            }
            
            let statusCode = httpResponse.statusCode
            let responseBody = data.flatMap { String(data: $0, encoding: .utf8) } ?? "No response body"
            
            
            
            completion(.success((statusCode: statusCode, responseBody: responseBody)))


        }
        
        task.resume()
    }
}

enum NetworkError: Error, CustomStringConvertible {
    case invalidURL
    case badResponse
    case serverError(message: String)
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .badResponse:
            return "Response not received."
        case .serverError(let message):
            return message
        }
    }
}
