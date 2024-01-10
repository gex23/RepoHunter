//
//  SearchResponse.swift
//  RepoHunter
//
//  Created by Gergely Barka on 10/01/2024.
//

import Foundation

struct SearchResponse: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [RepositoryRaw]
}
