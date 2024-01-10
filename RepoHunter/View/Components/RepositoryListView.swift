//
//  RepositoryListView.swift
//  RepoHunter
//
//  Created by Gergely Barka on 10/01/2024.
//

import SwiftUI

struct RepositoryListView: View {
    @ObservedObject var viewModel: RepositoryListViewModel
    @Binding var scrollIndex: Int?

    var body: some View {
        switch viewModel.state {
        case .idle:
            VStack(alignment:.center, spacing: 2) {
                Text("Find your stuff")
                    .font(.headline)
                Text("Search all of GitHub for Repositories")
            }
            .padding(.top)
        case .loading :
            Text("Loading...")
                .font(.headline)
                .padding(.top)
        case .loaded(let repositories):
            ScrollViewReader { scrollViewProxy in
                List {
                    ForEach(repositories) { repository in
                        NavigationLink(destination:
                                        RepositoryDetailsView(repository: repository)
                            .navigationBarTitle(
                                Text("Repository Details")
                            )
                        ) {
                            RepositoryView(lastViewedId: $viewModel.lastViewedId, repository: repository)
                                .onAppear{
                                    viewModel.shouldLoadMore(current: repository)
                                }
                        }
                    }
                    if viewModel.isLoadingMore {
                        ProgressView {
                            Text("Fetching next page...")
                                .font(.footnote)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .onChange(of: viewModel.lastViewedId) { _ , newValue in
                    scrollIndex = newValue
                }
                .onChange(of: viewModel.repositories) { _ , _ in
                    if let itemId = scrollIndex {
                        scrollViewProxy.scrollTo(itemId, anchor: .bottom)
                        scrollIndex = nil
                    }
                }
                .refreshable {
                    viewModel.search()
                }
                .listStyle(.plain)
            }
        case .error(let error) :
            Text(error.message)
                .font(.headline)
                .padding(.top)
        }
    }
}
