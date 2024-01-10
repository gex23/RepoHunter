//
//  RepositoryOwner.swift
//  RepoHunter
//
//  Created by Gergely Barka on 10/01/2024.
//

import Foundation

struct RepositoryOwner: Decodable, Equatable {
    let login: String
    let avatarUrl: URL?
    let htmlUrl: URL?
}
