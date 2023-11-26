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
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("News API")
                SearchBar(searchText: $searchText, action: {
                    newsViewModel.fetchNews(for: searchText)
                })
                Spacer()
            }
            
            if newsViewModel.isLoading == true {
                ProgressView("Loading...")
                    .progressViewStyle(.circular)
            }
        }
        
    }
}

#Preview {
    SearchView()
}
