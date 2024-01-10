//
//  SearchBarView.swift
//  RepoHunter
//
//  Created by Gergely Barka on 09/01/2024.
//

import SwiftUI

struct SearchBarView: View {
    @ObservedObject var viewModel: RepositoryListViewModel
    var searchAction: () -> Void
    @State private var isFolded = true
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 10) {
                TextField(
                    "Search GitHub Repositories",
                    text: $viewModel.searchText
                )
                .focused($isInputActive)
                .frame(height: 36)
                .padding(.leading)
                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                .padding(.leading, 10)
                
                Image(systemName: isFolded ? "arrow.down.circle" : "arrow.up.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 8)
                    .onTapGesture {
                        self.isFolded.toggle()
                    }
            }
            
            if !isFolded {
                AdvancedSearchOptionsView(viewModel: viewModel)
            }
            
            Button(action: {
                isInputActive = false
                searchAction()
            }, label: {
                Text("Search").font(.headline)
            })
            .padding(.top)
        }
    }
}
