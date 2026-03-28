//
//  EventDetailViewModel.swift
//  Gatherly
//
//  Created by James Ellis on 3/28/26.
//

import Foundation
import Observation

@Observable
class EventDetailViewModel {
    let event: Event
    private let currentUserPid = "730739772"

    init(event: Event) {
        self.event = event
    }

    var isMine: Bool {
        event.creatorPid == currentUserPid
    }

    var navigationTitle: String {
        isMine ? "Your Event Details" : "Event Details"
    }

    var showRSVPButton: Bool {
        !isMine
    }

    var showEllipsisButton: Bool {
        isMine
    }
}
