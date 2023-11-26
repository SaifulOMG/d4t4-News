//
//  SearchBar.swift
//  d4t4 News
//
//  Created by Briteyellow on 26/11/2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var action: () -> ()
    var body: some View {
        HStack {
            TextField("Search...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading)
                .overlay(
                    HStack {
                        Spacer()
                        if !searchText.isEmpty {
                            Button(action: clearSearchText) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 8)
                        }
                    }
                )

            Button(action: action) {
                Text("Find")
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .frame(height: 35)
                    .background(Color.indigo)
                    .cornerRadius(5)
            }
            .padding(.trailing)
        }
    }
    
    private func clearSearchText() {
        searchText = ""
    }
}

#Preview {
    SearchBar(searchText: .constant(""), action: {})
}
