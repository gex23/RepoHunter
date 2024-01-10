//
//  RepositoryRaw.swift
//  RepoHunter
//
//  Created by Gergely Barka on 10/01/2024.
//

import Foundation

struct RepositoryRaw: Decodable, Equatable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let stargazersCount: Int
    let forksCount: Int
    let updatedAt: String?
    let createdAt: String?
    let htmlUrl: URL
    let owner: RepositoryOwner
    
    func mapToPlain() -> RepositoryItem {
        return RepositoryItem(
            id: self.id,
            name: self.name,
            fullName: self.fullName,
            description: self.description ?? "-",
            stargazersCount: self.stargazersCount,
            forksCount: self.forksCount,
            updatedAt: formatDate(self.updatedAt),
            createdAt: formatDate(self.createdAt),
            htmlUrl: self.htmlUrl,
            owner: self.owner
        )
    }
    
    static func mapRepositoryRawToPlain(raw: [RepositoryRaw]) -> [RepositoryItem] {
        return raw.map { article in
            article.mapToPlain()
        }
    }
}

extension RepositoryRaw {
    
    func formatDate(_ dateString: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let date = dateFormatter.date(from: dateString ?? "") else {
            return "Invalid date"
        }
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.string(from: date)
    }
}
