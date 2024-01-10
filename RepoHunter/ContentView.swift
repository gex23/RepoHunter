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
    @State private var scrollIndex: Int?
    @State private var search: String = ""
    
    @State private var isFolded = true
    
    @State private var sort = "stars"
    var sorting = ["stars", "updated"]
    
    @State private var order = "desc"
    var ordering = ["desc", "asc"]
    
    @FocusState private var isInputActive: Bool
    
    init(viewModel: RepositoryListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10 ) {
            VStack{
                HStack(alignment: .center, spacing: 10) {
                    TextField(
                        "Search GitHub Reposipories",
                        text: $viewModel.searchText
                    )
                    .focused($isInputActive)
                    .frame(height: 36)
                    .padding(.leading)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 1))
                    .padding(.leading, 10)
                    
                    if !isFolded {
                        Image(systemName: "arrow.up.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 8)
                            .onTapGesture {
                                self.isFolded.toggle()
                            }
                    } else {
                        Image(systemName: "arrow.down.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 8)
                            .onTapGesture {
                                self.isFolded.toggle()
                            }
                    }
                }
                
                if !isFolded {
                    VStack {
                        Picker("Sorting", selection: $viewModel.sort) {
                            Text("Stars").tag(Sort.stars)
                            Text("Updated").tag(Sort.updated)
                        }
                        .pickerStyle(.segmented)
                        .onChange(of: viewModel.sort) { _, _ in
                            viewModel.search()
                        }
                                            
                        Picker("Ordering", selection: $viewModel.order) {
                            Text("Descending").tag(Order.desc)
                            Text("Ascending").tag(Order.asc)
                        }
                        .pickerStyle(.segmented)
                        .onChange(of: viewModel.order) { _, _ in
                            viewModel.search()
                        }
                    }
                }
            }
            
            Button(
                action: {
                    isInputActive = false
                    viewModel.search()
                },
                label: {
                    Text("Search").font(.headline)
                }
            )
            .padding(.top)
            
            HStack {
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
                        List(repositories) { repository in
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
            viewModel: RepositoryListViewModel(httpClient: GitHubApi())
        )
    }
}
