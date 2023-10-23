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
    @Query var ideas: [AppIdea]
    
    @State private var showAddDialog = false
    
    @State private var newName = ""
    @State private var newDescription = ""
    
    
    var body: some View {
        NavigationStack {
            List(ideas) { idea in
                
            }
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
        .modelContainer(for: [AppIdea.self, AppFeature.self], inMemory: true)
}
