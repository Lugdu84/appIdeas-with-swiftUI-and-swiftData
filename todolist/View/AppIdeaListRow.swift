//
//  AppIdeaListRow.swift
//  todolist
//
//  Created by David Grammatico on 24/10/2023.
//

import SwiftUI

struct AppIdeaListRow: View {
    @Environment(\.modelContext) private var modelContext
    var idea: AppIdea
    var body: some View {
        NavigationLink(value: idea) {
            VStack(alignment: .leading) {
                Text(idea.name)
                    .font(.headline)
                Text(idea.detailedDescription)
                    .textScale(.secondary)
                    .foregroundStyle(.secondary)
            }
        }
        .swipeActions(edge: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/, allowsFullSwipe: false) {
            Button(role: .destructive) {
                idea.isArchived = true
            } label: {
                Label("Archive", systemImage: "archivebox")
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: false) {
            Button {
                idea.isFavorite.toggle()
            } label: {
                Label("Favorite", systemImage: idea.isFavorite ? "heart.slash.fill" : "heart.fill")
            }
            .tint(.yellow)
        }
        .sensoryFeedback(.decrease, trigger: idea.isArchived)
        .sensoryFeedback(.increase, trigger: idea.isFavorite)
    }
}
