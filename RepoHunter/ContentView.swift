//
//  ContentView.swift
//  RepoHunter
//
//  Created by Gergely Barka on 05/01/2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var viewModel: RepositoryListViewModel
    @State private var search: String = ""
    
    init(viewModel: RepositoryListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                
                TextField(
                    "Search GitHub Reposipories",
                    text: $viewModel.text
                )
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1))
                .padding()
                
                Button(
                    action: {
                        viewModel.fetchRepositories(search: viewModel.text)
                    },
                    label: {
                        Text("Search").font(.headline)
                    }
                ).padding()
            }
            
            Spacer()
            
            switch viewModel.state {
            case .idle:
                Text("Idle")
            case .loading :
                Text("Loading...")
            case .loaded(let repositories):
                List(repositories) { repository in
                    NavigationLink(destination:
                                    WebView(url: repository.htmlUrl)
                        .navigationBarTitle(
                            Text(repository.owner.login).font(.title)
                        )
                    ) {
                        RepositoryView(repository: repository)
                    }
                }
                
            case .error(_) :
                Text("An error occure")
            }
        }
        .navigationBarTitle(
            Text("Search 🔍")
        )
    }
    
}

#Preview {
    NavigationStack {
        ContentView(
            viewModel: RepositoryListViewModel(httpClient: HTTPClient())
        )
    }
}
