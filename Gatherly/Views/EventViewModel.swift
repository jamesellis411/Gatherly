//
//  EventsViewModel.swift
//  Gatherly
//
//  Created by James Ellis on 2/14/26.
//

import Foundation
import Observation

@Observable
class EventViewModel {
    var events: [Event] = []
    var loadingState: LoadingState = .idle
    var searchText = ""
    var filteredEventIndices: [Int] {
        events.indices.filter { i in
            searchText.isEmpty || events[i].title.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func fetchEvents() async {
        loadingState = .loading
        do {
            let fetched = try await EventService.shared.fetchEvents()
            events = fetched
            loadingState = .success
        } catch let error as ErrorType {
            loadingState = .failed(error)
        } catch {
            loadingState = .failed(.unknown)
        }
    }
    
    func deleteEvent(id: String) async throws {
        try await EventService.shared.deleteEvent(id: id)
    }
}
