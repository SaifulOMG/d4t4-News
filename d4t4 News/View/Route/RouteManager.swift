//
//  RouteManager.swift
//  d4t4 News
//
//  Created by Briteyellow on 26/11/2023.
//

import SwiftUI

enum Routes {
    case searchView
    case detailView
}

//Manage navigation route
struct RouteManager: View {
    @State private var navPaths = [Routes]()
    
    var body: some View {
        NavigationStack(path: $navPaths) {
            SearchView(navPaths: $navPaths).navigationDestination(for: Routes.self) { r in
                switch(r) {
                case .searchView:
                    SearchView(navPaths: $navPaths)
                        .navigationBarBackButtonHidden(true)
                case .detailView:
                    DetailView()
                }
            }
        }.environmentObject(NewsViewModel())
    }
}

#Preview {
    RouteManager()
}
