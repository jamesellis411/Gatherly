//
//  EditEventViewModel.swift
//  Gatherly
//
//  Created by James Ellis on 2/14/26.
//

import Foundation
import Observation

@Observable
class EditEventViewModel {
    var id: String?
    var creatorPid: String
    var title: String
    var location: String
    var description: String
    var timestamp: Date
    var image_url: String?
    var image: String?

    init(event: Event) {
        self.id = event.id
        self.creatorPid = event.creatorPid
        self.title = event.title
        self.location = event.location
        self.description = event.description
        self.timestamp = event.timestamp
        self.image_url = event.image_url
        self.image = event.image
    }
}
