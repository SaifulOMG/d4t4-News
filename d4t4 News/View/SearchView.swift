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
            Color.blue.ignoresSafeArea()
            
            VStack {
                Text("News API")
                    .foregroundStyle(.white)
                    .font(.system(size: 24))
                SearchBar(searchText: $searchText, action: {
                    newsViewModel.fetchNews(for: searchText)
                })
                
                if newsViewModel.isLoading == false && newsViewModel.articles.count != 0 {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .overlay(content: {
                            TableView(items: $newsViewModel.articles, selectedItem: $selectedArticle)
                                .padding([.trailing, .top, .bottom], 4)
                        })
                        .padding([.leading, .trailing, .top, .bottom])
                } else {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .padding([.leading, .trailing, .top, .bottom], 15)
                }
            }
            
            if newsViewModel.isLoading == true {
                ProgressView("Loading...")
                    .progressViewStyle(.circular)
                    .scaleEffect(1.5)
                    .tint(.blue)
                    .foregroundStyle(.blue)
            }
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

