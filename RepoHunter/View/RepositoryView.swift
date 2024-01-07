//
//  RepositoryView.swift
//  RepoHunter
//
//  Created by Gergely Barka on 07/01/2024.
//

import SwiftUI

struct RepositoryView: View {
    
    let repository: Repository
    
    var body: some View {
        HStack {
            AsyncImage(url: repository.owner.avatarUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
            } placeholder: {
                ProgressView()
            }
            Text(repository.fullName)
        }
    }
}
