//
//  RequestParameters.swift
//  RepoHunter
//
//  Created by Gergely Barka on 09/01/2024.
//

import Foundation

enum Sort: String {
    case stars
    case updated
}

enum Order: String {
    case desc
    case asc
}

struct RequestParameters {
    let query: String
    let sort: Sort
    let order: Order
    let perPage: Int
    let page: Int

    static let offsetBase = 1 

    func dictionary() -> [String: Any] {
        return [
            "q": query,
            "sort": sort.rawValue,
            "order": order.rawValue,
            "per_page": perPage,
            "page": page
        ]
    }
}
