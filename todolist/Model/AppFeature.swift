//
//  AppFeature.swift
//  todolist
//
//  Created by David Grammatico on 23/10/2023.
//

import SwiftUI
import SwiftData

@Model
class AppFeature {
    @Attribute(.unique) var detailedDescription: String
    var creationDate: Date
    
    init(detailedDescription: String) {
        self.detailedDescription = detailedDescription
        self.creationDate = .now
    }
}
