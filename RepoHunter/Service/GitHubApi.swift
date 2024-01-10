//
//  HTTPClient.swift
//  RepoHunter
//
//  Created by Gergely Barka on 06/01/2024.
//

import Foundation
import Combine

enum ApiError: Error, Equatable {
    case badUrl
    case failedStatusError
    case decodingError
    case customError(String)

    var message: String {
        switch self {
        case .badUrl:
            return "A wrong URL called."
        case .failedStatusError:
            return "A request ended with failed status."
        case .decodingError:
            return "Failed to decode data."
        case .customError(let message):
            return message
        }
    }
}

struct GitHubApi {
    
    func searchRepositories(requestParameters: RequestParameters) -> AnyPublisher<SearchResponse, ApiError> {
        
        var components = URLComponents(string: "https://api.github.com/search/repositories")
        components?.queryItems = requestParameters.dictionary().map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }        
        
        guard let url = components?.url else {
            return Fail(error: ApiError.badUrl).eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap{ (data, response) in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw ApiError.failedStatusError
                }
                
                return data
            }
            .decode(type: SearchResponse.self, decoder: decoder)
            .mapError{ error -> ApiError in
                if let apiError = error as? ApiError {
                    return apiError
                } else if error is DecodingError {
                    return ApiError.decodingError
                } else {
                    return ApiError.customError("The network request has failed.")
                }
            }
            .eraseToAnyPublisher()
    }
}
