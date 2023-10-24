//
//  AppIdea.swift
//  todolist
//
//  Created by David Grammatico on 23/10/2023.
//

import SwiftData
import SwiftUI

@Model
class AppIdea {
    @Attribute(.unique) var name: String
    var detailedDescription: String
    var creationDate: Date
    var isArchived: Bool = false
    var isFavorite: Bool = false
    
    init(name: String, detailedDescription: String, isArchived: Bool = false, isFavorite: Bool = false) {
        self.name = name
        self.detailedDescription = detailedDescription
        self.creationDate = .now
        self.isArchived = isArchived
        self.isFavorite = isFavorite
    }
    
    @Relationship(deleteRule: .cascade)
    var features: [AppFeature] = []
}
