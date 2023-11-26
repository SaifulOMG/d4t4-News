//
//  NewsViewModel.swift
//  d4t4 News
//
//  Created by Briteyellow on 26/11/2023.
//

import Foundation

@MainActor
class NewsViewModel: ObservableObject {
    @Published var articles: [ArticleDetail] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let newsSearchRequest = NewsSearchRequest()

    func fetchNews(for searchPath: String) {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                let fetchedArticles = try await newsSearchRequest.searchNews(searchPath: searchPath)

                if fetchedArticles.status == NewsApiStatus.error.identifier {
                    guard let message = fetchedArticles.message else {
                        return
                    }
                    print(message)
                    self.errorMessage = message
                } else {
                    print("Success")
                }
                
                self.articles = fetchedArticles.articles ?? []
                self.isLoading = false
            } catch {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
