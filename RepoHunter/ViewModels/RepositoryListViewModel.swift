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
    case error(ApiError)
}

class RepositoryListViewModel: ObservableObject {
    
    private let httpClient: HTTPClient
    private var cancellables: Set<AnyCancellable> = []
    var text: String = ""
    
    @Published private(set) var repositories: [Repository] = []
    @Published var state: FetchingState = .idle
    
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
        
    }
    
    func fetchRepositories() {
        self.state = .loading
        httpClient.searchRepositories(search: text)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.state = .error(error)
                }
            }, receiveValue: { [weak self] repositories in
                self?.state = .loaded(repositories)
            })
            .store(in: &cancellables)
    }
}
