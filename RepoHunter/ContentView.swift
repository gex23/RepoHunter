//
//  SearchContentView.swift
//  RepoHunter
//
//  Created by Gergely Barka on 10/01/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: RepositoryListViewModel
    @State private var scrollIndex: Int?
    
    init(viewModel: RepositoryListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            SearchBarView(viewModel: viewModel) {
                viewModel.search()
            }
            RepositoryListView(viewModel: viewModel, scrollIndex: $scrollIndex)            
        }
        .navigationBarTitle(Text("Search 🔍"))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.all, 5)
    }
}

#Preview {
    NavigationStack {
        ContentView(
            viewModel: RepositoryListViewModel(httpClient: GitHubApi())
        )
    }
}
