//
//  SearchView.swift
//  d4t4 News
//
//  Created by Briteyellow on 25/11/2023.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            SearchBar(searchText: $searchText, action: {
                
            })
        }
    }
}

#Preview {
    SearchView()
}
