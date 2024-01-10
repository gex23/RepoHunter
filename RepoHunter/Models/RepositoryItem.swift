//
//  Repository.swift
//  RepoHunter
//
//  Created by Gergely Barka on 06/01/2024.
//

import Foundation

struct RepositoryItem: Identifiable, Decodable, Equatable {
    let id: Int
    let name: String
    let fullName: String
    let description: String
    let stargazersCount: Int
    let forksCount: Int
    let updatedAt: String
    let createdAt: String
    let htmlUrl: URL
    let owner: RepositoryOwner
}
