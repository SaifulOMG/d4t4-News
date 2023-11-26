//
//  SearchView.swift
//  d4t4 News
//
//  Created by Briteyellow on 25/11/2023.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject private var newsViewModel = NewsViewModel()
    @State private var selectedArticle: ArticleDetail?
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("News API")
                SearchBar(searchText: $searchText, action: {
                    newsViewModel.fetchNews(for: searchText)
                })
                
                if newsViewModel.isLoading == false && newsViewModel.articles.count != 0 {
                    TableView(items: $newsViewModel.articles, selectedItem: $selectedArticle)
                        .padding([.trailing, .top, .bottom])
                } else {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.black, lineWidth: 0.10)
                        .padding([.leading, .trailing, .top, .bottom], 15)
                }
            }
            
            if newsViewModel.isLoading == true {
                ProgressView("Loading...")
                    .progressViewStyle(.circular)
            }
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
       //     .environmentObject(mockNewsViewModel())
    }

//    static func mockNewsViewModel() -> NewsViewModel {
//        let viewModel = NewsViewModel()
//        viewModel.articles = [ArticleDetail(title: "Sample News", author: "Test")] 
//        return viewModel
//    }
}

