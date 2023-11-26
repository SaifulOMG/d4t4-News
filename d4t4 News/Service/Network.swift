//
//  Network.swift
//  d4t4 News
//
//  Created by Briteyellow on 25/11/2023.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case decodingError
    case encodingError
    case noData
    case responseProblem
}

class NetworkRequest {
    //MARK:- GET
    func getData<T: Codable>(searchPath: String, expectedReturnType: T.Type) async throws -> T {
        do {
            let apiKey = try Security().getApiKeyToKeychain()
            
            guard let url = URL(string: "\(InfoPlistParser.getStringValue(forKey: "API URL"))q=\(searchPath)&apiKey=" + apiKey) else {
                throw NetworkError.badURL
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                throw NetworkError.responseProblem
            }
            
            let authData = try JSONDecoder().decode(T.self, from: data)
            return authData
        } catch {
            print("Failed to make get request\(error)")
            throw error
        }
    }
}
