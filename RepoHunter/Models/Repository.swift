//
//  Repository.swift
//  RepoHunter
//
//  Created by Gergely Barka on 06/01/2024.
//

import Foundation

enum ListItem {
    case repository(Repository)
    case loading
}

struct SearchResponse: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]
}

struct Repository: Identifiable, Decodable, Equatable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let stargazersCount: Int
    let forksCount: Int
    let updatedAt: String?
    let createdAt: String?
    let url: URL
    let htmlUrl: URL
    let owner: RepositoryOwner
}

struct RepositoryOwner: Decodable, Equatable {
    let login: String
    let avatarUrl: URL?
    let url: URL?
}
