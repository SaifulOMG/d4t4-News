//
//  SearchView.swift
//  d4t4 News
//
//  Created by Briteyellow on 25/11/2023.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var newsViewModel: NewsViewModel
    @State private var searchText = ""
    @Binding var navPaths: [Routes]
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
                
                if !newsViewModel.isLoading && !newsViewModel.articles.isEmpty {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .overlay(content: {
                            TableView(navigate: {
                                navPaths.append(.detailView)
                            })
                                .padding([.trailing, .top, .bottom], 4)
                        })
                        .padding([.leading, .trailing, .top, .bottom])
                } else {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .padding([.leading, .trailing, .top, .bottom], 15)
                }
            }

            if newsViewModel.isLoading {
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
        SearchView(navPaths: .constant([])).environmentObject(NewsViewModel())
    }
}
