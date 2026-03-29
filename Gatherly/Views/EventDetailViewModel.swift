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
    var event: Event
    var errorString: String = ""
    var isError: Bool = false
    private let currentUserPid = "730739772"

    init(event: Event) {
        self.event = event
    }

    func refresh() async {
        guard let id = event.id else { return }
        do {
            event = try await EventService.shared.fetchEvent(id: id)
        } catch let error as ErrorType {
            errorString = error.localizedDescription
            isError = true
        } catch {
            errorString = error.localizedDescription
            isError = true
        }
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
