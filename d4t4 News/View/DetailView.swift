//
//  DetailView.swift
//  d4t4 News
//
//  Created by Briteyellow on 26/11/2023.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var newsViewModel: NewsViewModel
    
    var body: some View {
        if let urlString = newsViewModel.selectedItemURL {
            ZStack {
                Color.blue
                //Show Web Content
                WebView(urlString: urlString)
                    .ignoresSafeArea()
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView().environmentObject(NewsViewModel())
    }
}
