//
//  RepositoryDetailsView.swift
//  RepoHunter
//
//  Created by Gergely Barka on 08/01/2024.
//

import SwiftUI

struct RepositoryDetailsView: View {
    
    let repository: Repository
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                AsyncImage(url: repository.owner.avatarUrl) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 45, height: 45)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                .shadow(radius: 10)
                
                VStack(alignment: .leading){
                    Text("\(repository.owner.login)")
                        .font(.headline)
                    
                    Text("\(repository.owner.url?.absoluteString ?? "No profile link")")
                        .font(.footnote)

                }
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text("\(repository.name)")
                    .font(.title)
                
                
                Text("\(repository.url.absoluteString)")
                    .font(.footnote)
                    .padding(.bottom, 10)
                
                Text("\(repository.description ?? "No description")")
                    .font(.caption)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(repository.stargazersCount) stars")
                    .font(.title3)
                
                Text("Created: \(repository.createdAt ?? "No created date")")
                    .font(.footnote)
                
                Text("Updated: \(repository.updatedAt ?? "No updated date")")
                    .font(.footnote)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.leading)
    }
}


//#Preview {
//    RepositoryDetailsView(
//        repository: Repository(
//            id: 0,
//            name: "name",
//            fullName: "full name",
//            description: "This is a description",
//            stargazersCount: 35,
//            forksCount: 2,
//            updatedAt: "2012-01-01T00:31:50Z",
//            createdAt: "2012-01-01T00:31:50Z",
//            url: URL(string: "https://github.com/dtrupenn/Tetris")!,
//            htmlUrl: URL(string: "https://github.com/dtrupenn/Tetris")!,
//            owner: RepositoryOwner(
//                login: "ownerlogin",
//                avatarUrl: URL(string: "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"),
//                url: URL(string: "https://api.github.com/users/dtrupenn")
//            )
//        )
//    )
//}
