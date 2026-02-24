//
//  EventDetailViewModel.swift
//  Gatherly
//
//  Created by James Ellis on 2/24/26.
//

import Foundation
import Observation

@Observable
class EventDetailViewModel {
    var id: String?
    var creatorPid: String
    var title: String
    var location: String
    var description: String
    var timestamp: Date
    var image_url: String?
    
    init(event: Event) {
        self.id = event.id
        self.creatorPid = event.creatorPid
        self.title = event.title
        self.location = event.location
        self.description = event.description
        self.timestamp = event.timestamp
        self.image_url = event.image_url
    }
    
    
}
