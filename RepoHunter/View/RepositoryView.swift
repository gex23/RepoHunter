//
//  RepositoryView.swift
//  RepoHunter
//
//  Created by Gergely Barka on 07/01/2024.
//

import SwiftUI

struct RepositoryView: View {
    
    @Binding var lastViewedId: Int?
    
    let repository: RepositoryItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(repository.name)")
                .font(.headline)
            
            Text("\(repository.description)")
                .font(.caption)
                .lineLimit(3)
            
            HStack(alignment: .center, spacing: 2) {
                Text("\(repository.stargazersCount)")
                    .font(.title3)
                Image(systemName: "star")
                
                Spacer()
                
                Text("\(repository.updatedAt)")
                    .font(.caption2)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .onAppear{
            lastViewedId = repository.id
        }
    }
}
