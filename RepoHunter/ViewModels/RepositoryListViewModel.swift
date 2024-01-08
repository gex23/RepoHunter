//
//  RepositoryListVIewModel.swift
//  RepoHunter
//
//  Created by Gergely Barka on 07/01/2024.
//

import Foundation
import Combine

enum FetchingState {
    case idle
    case loading
    case loaded([Repository])
    case error(NetworkError)
}

class RepositoryListViewModel: ObservableObject {
    
    private let httpClient: HTTPClient
    
    private var cancellables: Set<AnyCancellable> = []
    @Published  var searchSubject = CurrentValueSubject<String, Never>("")
    @Published private(set) var repositories: [Repository] = []
    
    @Published var state: FetchingState = .idle
    
    var text: String = ""
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
        self.setupSearchPublisher()
    }
    
    func setupSearchPublisher() {
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { searchText in
                self.fetchRepositories(search: searchText)
            }.store(in: &cancellables)
    }
    
    func fetshRepositories(search: String) {
        httpClient.searchRepositories(search: search)
            .sink { _  in
            } receiveValue: { repositories in
                self.repositories = repositories
            }
            .store(in: &cancellables)
    }
    
    func fetchRepositories(search: String) {
        self.state = .loading
        httpClient.searchRepositories(search: search)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self?.state = .error(.unknownError)
                }
            }, receiveValue: { [weak self] repositories in
                self?.state = .loaded(repositories)
            })
            .store(in: &cancellables)
    }
    
}
