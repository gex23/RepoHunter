//
//  HTTPClient.swift
//  RepoHunter
//
//  Created by Gergely Barka on 06/01/2024.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badUrl
    case unknownError
}

class HTTPClient {
    
    func searchRepositories(search: String) -> AnyPublisher<[Repository], Error> {
        guard let encodedSearch = search.urlEncoded,
              let url = URL(string: "https://api.github.com/search/repositories?q=\(encodedSearch)")
        else {
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: SearchResponse.self, decoder: decoder)
            .map(\.items)
            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[Repository], Error> in
                switch error {
                case is DecodingError:
                    return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
                default:
                    return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
                }
                
            }
            .eraseToAnyPublisher()
    }
    
}
