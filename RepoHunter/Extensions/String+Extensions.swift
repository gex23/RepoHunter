//
//  String+Extensions.swift
//  RepoHunter
//
//  Created by Gergely Barka on 06/01/2024.
//

import Foundation

extension String {
    
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
