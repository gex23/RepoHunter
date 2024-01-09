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
        VStack(alignment: .leading, spacing: 8) {
            Text("\(repository.name)")
                .font(.headline)
            
            Text("\(repository.description ?? "-")")
                .font(.caption)
            
            HStack(alignment: .bottom, spacing: 2) {
                Text("\(repository.stargazersCount) stars")
                    .font(.title3)
                
                Spacer()
                
                Text("Updated at \(repository.updatedAt ?? "-")")
                    .font(.caption2)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}


#Preview {
    RepositoryView(
        repository: Repository(
            id: 0,
            name: "name",
            fullName: "full name",
            description: "This is a description",
            stargazersCount: 35,
            forksCount: 2,
            updatedAt: "2012-01-01T00:31:50Z",
            createdAt: "2012-01-01T00:31:50Z",
            url: URL(string: "https://github.com/dtrupenn/Tetris")!,
            htmlUrl: URL(string: "https://github.com/dtrupenn/Tetris")!,
            owner: RepositoryOwner(
                login: "ownerlogin",
                avatarUrl: URL(string: "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"),
                url: URL(string: "https://api.github.com/users/dtrupenn")
            )
        )
    )
}
