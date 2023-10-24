//
//  ContentView.swift
//  todolist
//
//  Created by David Grammatico on 23/10/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(
        filter: #Predicate<AppIdea> {
        $0.isArchived == false
        },
        sort: \.creationDate,
        order: .forward,
        animation: .easeIn) var ideas: [AppIdea]
    
    var favoriteIdeas: [AppIdea] {
        ideas.filter{$0.isFavorite}
    }
    
    var nonFavoriteIdeas: [AppIdea] {
        ideas.filter{$0.isFavorite == false}
    }
    
    @State private var showAddDialog = false
    @State private var newName = ""
    @State private var newDescription = ""
    
    
    var body: some View {
        NavigationStack {
            Group {
                if ideas.isEmpty {
                    ContentUnavailableView(
                        "No AppIdeas",
                        systemImage: "square.stack.3d.up.slash",
                        description: Text("Tap add to create your first AppIdea")
                    )
                } else {
                    List {
                        Section("Favorites") {
                            ForEach(favoriteIdeas) { idea in
                                AppIdeaListRow(idea: idea)
                            }
                        }
                        Section("All") {
                            ForEach(ideas) { idea in
                                AppIdeaListRow(idea: idea)
                            }
                        }
                    }
                }
            }
//            List(ideas) { AppIdeaListRow(idea: $0)}
            .navigationTitle("App Ideas")
            .navigationDestination(for: AppIdea.self, destination: {EditAppIdeaView(idea: $0)})
            .toolbar {
                Button("Add") {
                    showAddDialog.toggle()
                }
            }
            .sheet(isPresented: $showAddDialog, content: {
                NavigationStack {
                    Form(content: {
                        TextField("Name", text: $newName)
                        TextField("Description", text: $newDescription, axis: .vertical)
                    })
                    .navigationTitle("New App Idea")
                    .toolbar {
                        Button("Dismiss") {
                            closeAddDialog()
                        }
                        Button("Save") {
                            let idea = AppIdea(name: newName, detailedDescription: newDescription)
                            modelContext.insert(idea)
                            closeAddDialog()
                        }
                    }
                }
            })
        }
    }
    
    func closeAddDialog () {
        showAddDialog.toggle()
        newName = ""
        newDescription = ""
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [AppIdea.self, AppFeature.self], inMemory: false)
}
