//
//  EditAppIdeaView.swift
//  todolist
//
//  Created by David Grammatico on 24/10/2023.
//

import SwiftUI
import SwiftData

struct EditAppIdeaView: View {
    @Bindable var idea: AppIdea
    
    @State private var newFeatureDescription = ""
    var body: some View {
        Form {
            TextField("Name", text: $idea.name)
            TextField("Description", text: $idea.detailedDescription)
            
            Section("Features") {
                TextField("New Feature", text: $newFeatureDescription)
                    .onSubmit {
                        let feature = AppFeature(detailedDescription: newFeatureDescription)
                        newFeatureDescription.removeAll()
                        idea.features.append(feature)
                    }
                ForEach(idea.features) { feature in
                    Text(feature.detailedDescription)
                }
            }
        }
    }
}

