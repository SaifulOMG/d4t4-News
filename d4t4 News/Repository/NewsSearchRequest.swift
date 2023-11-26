//
//  NewsSearchRequest.swift
//  d4t4 News
//
//  Created by Briteyellow on 26/11/2023.
//

import Foundation

class NewsSearchRequest {

    func searchNews(searchPath: String) async throws -> Articles {
        do {
            let data = try await NetworkRequest().getData(searchPath: searchPath, expectedReturnType: Articles.self)
            return data
        } catch {
            print("Error getting News data")
            throw error
        }
    }
}
