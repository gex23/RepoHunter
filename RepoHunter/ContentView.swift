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
        VStack() {
            HStack(alignment: .firstTextBaseline, spacing: 10) {
                TextField(
                    "Search GitHub Reposipories",
                    text: $viewModel.text
                )
                .frame(height: 45)
                .padding(.leading)
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 1))
                .padding(.leading, 10)
                
                Button(
                    action: {
                        viewModel.fetchRepositories(search: viewModel.text)
                    },
                    label: {
                        Text("Search").font(.headline)
                    }
                )
                .padding(.trailing, 20)
            }
            
            HStack {
                switch viewModel.state {
                case .idle:
                    Text("Idle")
                case .loading :
                    Text("Loading...")
                case .loaded(let repositories):
                    List(repositories) { repository in
                        NavigationLink(destination:
                                        RepositoryDetailsView(repository: repository)
                            .navigationBarTitle(
                                Text("Repository Details")
                            )
                        ) {
                            RepositoryView(repository: repository)
                        }
                    }
                    .listStyle(.plain)
                case .error(_) :
                    Text("An error occure")
                }
            }
        }
        .navigationBarTitle(
            Text("Search 🔍")
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.leading, 5)
        .padding(.trailing, 5)
        .padding(.top, 5)
        .padding(.bottom, 5)
    }
    
}

#Preview {
    NavigationStack {
        ContentView(
            viewModel: RepositoryListViewModel(httpClient: HTTPClient())
        )
    }
}
