//
//  AdvancedSearchOptionsView.swift
//  RepoHunter
//
//  Created by Gergely Barka on 10/01/2024.
//

import SwiftUI

struct AdvancedSearchOptionsView: View {
    @ObservedObject var viewModel: RepositoryListViewModel
    
    var body: some View {
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
