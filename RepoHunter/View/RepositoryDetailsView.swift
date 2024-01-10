//
//  RepositoryDetailsView.swift
//  RepoHunter
//
//  Created by Gergely Barka on 08/01/2024.
//

import SwiftUI

struct RepositoryDetailsView: View {
    
    let repository:  RepositoryItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .center, spacing: 10) {
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
                
                HStack(alignment: .center, spacing: 10){
                    Text("\(repository.owner.login)")
                        .font(.headline)
                    
                    Link(destination: URL(string: repository.owner.htmlUrl?.absoluteString ?? "https://github.com")!) {
                        Image(systemName: "link.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center) {
                    Text("\(repository.name)")
                        .font(.title)
                    
                    Link(destination: URL(string: repository.htmlUrl.absoluteString)!) {
                        Image(systemName: "link.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                
                Text("\(repository.description)")
                    .font(.caption)
            }
            
            HStack(alignment: .center, spacing: 10) {
                HStack(alignment: .center, spacing: 5) {
                    Text("\(repository.stargazersCount)")
                        .font(.caption)
                    Image(systemName: "star")
                    
                    Text("\(repository.forksCount)")
                        .font(.caption)
                    Image(systemName: "arrow.triangle.branch")
                    
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Created: \(repository.createdAt)")
                        .font(.caption2)
                    
                    Text("Updated: \(repository.updatedAt)")
                        .font(.caption2)
                }
            }.padding(.trailing)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.leading)
    }
}
