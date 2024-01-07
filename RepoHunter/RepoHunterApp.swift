//
//  RepoHunterApp.swift
//  RepoHunter
//
//  Created by Gergely Barka on 05/01/2024.
//

import SwiftUI

@main
struct RepoHunterApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView(httpClient: HTTPClient())
            }
        }
    }
}
