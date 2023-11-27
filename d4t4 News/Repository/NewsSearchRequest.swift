//
//  NewsSearchRequest.swift
//  d4t4 News
//
//  Created by Briteyellow on 26/11/2023.
//

import Foundation

class NewsSearchRequest {
    //data handling
    func searchNews(searchPath: String, fromDate: Date, toDate: Date) async throws -> Articles {
        do {
            let dateFormatter = DateFormatter() //format date before adding to endpoint
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let fromData = dateFormatter.string(from: fromDate)
            let toDate = dateFormatter.string(from: toDate)
            
            print(fromData)
            print(toDate)
            
            let data = try await NetworkRequest().getData(searchPath: searchPath, fromDate: fromData, toDate: toDate, expectedReturnType: Articles.self)
            return data
        } catch {
            print("Error getting News data")
            throw error
        }
    }
}
