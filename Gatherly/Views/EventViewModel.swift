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
    var errorString: String = ""
    var isError: Bool = false
    
    enum SortOption {
        case none, alphabetical, upcoming
    }
    
    var sortOption: SortOption = .none
    
    var filteredAndSortedEvents: [Event] {
        // handles searchText
        var eventsToShow = events.filter { event in
            searchText.isEmpty || event.title.localizedCaseInsensitiveContains(searchText)
      }
                
      switch sortOption {
      case .none:
          break
      case .alphabetical:
          eventsToShow.sort { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
      case .upcoming:
          // first filters only events whose dates have not passed
          // Date.now == this moment in time, so anything greater than this is a future Date
          eventsToShow = eventsToShow.filter { event in
            event.timestamp > Date.now
        }
        // sorts the upcoming events by their date
        eventsToShow.sort { $0.timestamp < $1.timestamp }
      }
      return eventsToShow
    }
    
    func fetchEvents() async {
        loadingState = .loading
        do {
            let fetched = try await EventService.shared.fetchEvents()
            events = fetched
            loadingState = .success
        } catch let error as ErrorType {
            loadingState = .failed(error)
            isError = true
            errorString = error.localizedDescription
        } catch {
            loadingState = .failed(.unknown)
            isError = true
            errorString = error.localizedDescription
        }
    }
    
    func deleteEvent(id: String) async throws {
        try await EventService.shared.deleteEvent(id: id)
    }
}
