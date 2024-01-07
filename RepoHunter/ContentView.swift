//
//  ContentView.swift
//  RepoHunter
//
//  Created by Gergely Barka on 05/01/2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var repositories: [Repository] = []
    @State private var search: String = ""
    
    private let httpClient: HTTPClient
    
    @State private var cancellables: Set<AnyCancellable> = []
    private var searchSubject = CurrentValueSubject<String, Never>("")
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    private func setupSearchPublisher() {
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { searchText in
                fetshRepositories(search: searchText)
            }.store(in: &cancellables)
    }
    
    private func fetshRepositories(search: String) {
        httpClient.searchRepositories(search: search)
            .sink { _  in                
            } receiveValue: { repositories in
                self.repositories = repositories
            }.store(in: &cancellables)
    }

    
    var body: some View {
        List(repositories) { repository in
            RepositoryView(repository: repository)
        }
        .onAppear {
            setupSearchPublisher()
        }
        .searchable(text: $search)
        .onChange(of: search) {
            searchSubject.send(search)
        }
    }
}

#Preview {
    NavigationStack {
        ContentView(
            httpClient: HTTPClient()
        )
    }
}
