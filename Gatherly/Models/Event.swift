//
//  Event.swift
//  Gatherly
//
//  Created by James Ellis on 2/5/26.
//
import Foundation
import CoreLocation

struct Event: Hashable, Codable, Identifiable {
    var id: String?
    var creatorPid: String = "730739772"
    var title: String
    var location: String
    var description: String
    var timestamp: Date
    var image_url: String?
    var image: String?
}

extension Event {
    static var example: Event =
        .init(
            title: "Sunset Concert",
            location: "Student Union Ballroom",
            description: "Join fellow students for a night of collaborative coding, snacks, and fun.",
            timestamp: Date()
        )
}

struct EventAnnotation: Identifiable {
    var id: String
    var event: Event
    var coordinate: CLLocationCoordinate2D
}
