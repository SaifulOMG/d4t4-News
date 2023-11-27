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
    //Get Request
    func getData<T: Codable>(searchPath: String, fromDate: String, toDate: String, expectedReturnType: T.Type) async throws -> T {
        do {
            let apiKey = try Security().getApiKeyToKeychain()
            //q is restricted to title of user input
            //use given date default is todays date
            //language is english
            //Example: https://newsapi.org/v2/everything?q=bitcoin&searchIn=title&from=2023-11-26&to=2023-11-26&language=en&apiKey=710119f4520a4c25b4ab12e46322e7db
            guard let url = URL(string: "\(InfoPlistParser.getStringValue(forKey: "API URL"))q=\(searchPath)&searchIn=title&from=\(fromDate)&to=\(toDate)&language=en&apiKey=" + apiKey) else {
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
