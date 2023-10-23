//
//  todolistApp.swift
//  todolist
//
//  Created by David Grammatico on 23/10/2023.
//

import SwiftUI

@main
struct todolistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [AppIdea.self, AppFeature.self], inMemory: true )
    }
}
