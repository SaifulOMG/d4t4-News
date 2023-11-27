//
//  NewsViewModel.swift
//  d4t4 News
//
//  Created by Briteyellow on 26/11/2023.
//

import Foundation

@MainActor
class NewsViewModel: ObservableObject {
    private let speechSynthesisService = SpeechSynthesisService()
    @Published var articles: [ArticleDetail] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedItemURL: String?
    private let newsSearchRequest = NewsSearchRequest()

    func fetchNews(for searchPath: String, fromDate: Date, toDate: Date) {
        isLoading = true
        errorMessage = nil

        //checking for errors when fetching. API may return errors
        Task {
            do {
                let fetchedArticles = try await newsSearchRequest.searchNews(searchPath: searchPath, fromDate: fromDate, toDate: toDate)

                if fetchedArticles.status == NewsApiStatus.error.identifier {
                    guard let message = fetchedArticles.message else {
                        return
                    }
                    print(message)
                    self.errorMessage = message
                } else {
                    guard let totalArticles = fetchedArticles.totalResults else {
                        return
                    }
                    print("Success with \(totalArticles) news articles")
                }
                
                self.articles = fetchedArticles.articles ?? []

                self.isLoading = false
            } catch {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func speakText(_ text: String) {
        speechSynthesisService.speak(text: text)
    }
}
