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
    case loaded([RepositoryItem])
    case error(ApiError)
}

class RepositoryListViewModel: ObservableObject {
    
    private let httpClient: GitHubApi
    private var cancellables: Set<AnyCancellable> = []
    
    private var maxDataCount = 0
    private var pageOffset = 1
    
                
    @Published private(set) var repositories: [RepositoryItem] = []
    @Published var state: FetchingState = .idle
    
    @Published var lastViewedId: Int?
    
    @Published var searchText: String = ""
    @Published var order: Order = .desc
    @Published var sort: Sort = .stars
    
    init(httpClient: GitHubApi) {
        self.httpClient = httpClient
    }
            
    func search() {
        if searchText.isEmpty {
            return
        }
        
        self.state = .loading
        self.pageOffset = 1
    
        fetch(loadMore: false)
    }
    
    private func fetch(loadMore: Bool) {
        let params =  RequestParameters(
            query: searchText,
            sort: self.sort,
            order: self.order,
            perPage: 30,
            page: pageOffset
        )
        
        httpClient.searchRepositories(requestParameters: params)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.state = .error(error)
                }
            }, receiveValue: { [weak self] searchResponse in
                self?.maxDataCount = searchResponse.totalCount
                if loadMore {
                    self?.repositories.append(contentsOf: RepositoryRaw.mapRepositoryRawToPlain(raw: searchResponse.items))
                } else {
                    self?.repositories = RepositoryRaw.mapRepositoryRawToPlain(raw: searchResponse.items)
                }
                self?.state = .loaded(self?.repositories ?? [])
            })
            .store(in: &cancellables)
    }
    
    func shouldLoadMore(current item: RepositoryItem) {
        if let lastItem = repositories.last, lastItem == item,
           repositories.count < maxDataCount {
            loadMore()
        }
    }
    
    func loadMore() {
        pageOffset += 1
        fetch(loadMore: true)
    }
}
