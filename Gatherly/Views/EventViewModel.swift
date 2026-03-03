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
    var searchText = ""
    var filteredEventIndices: [Int] {
        events.indices.filter { i in
            searchText.isEmpty || events[i].title.localizedCaseInsensitiveContains(searchText)
        }
    }

    func fetchEvents() async throws -> [Event] {
        // define url
        guard let url = URL(string: "https://gatherly-backend-q9vm.onrender.com/events") else {
            throw ErrorType.invalidURL
        }
        
        do {
            // perform network request using URLSession
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode response using JSONDecoder()
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            guard let response = try? decoder.decode(EventsResponse.self, from: data) else {
                throw ErrorType.codingError
            }
            return response.events
        } catch is URLError {
            throw ErrorType.networkError
        } catch {
            throw ErrorType.unknown
        }
    }
    
    func deleteEvent(id: String) async throws {
        try await EventService.shared.deleteEvent(id: id)
    }
}
