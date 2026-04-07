//
//  UserProfile.swift
//  Gatherly
//
//  Created by James Ellis on 3/20/26.
//
import Foundation
import SwiftData

@Model
class UserProfile {
    var imageData: Data?

    init(imageData: Data? = nil) {
        self.imageData = imageData
    }
}
