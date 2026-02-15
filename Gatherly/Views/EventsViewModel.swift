//
//  EventsViewModel.swift
//  Gatherly
//
//  Created by James Ellis on 2/14/26.
//

import Foundation
import Observation

@Observable
class EventsViewModel {
    var events: [Event] = []
    
    func fetchEvents() async {
        // define url
        guard let url = URL(string: "https://gatherly-backend-q9vm.onrender.com/events") else { fatalError("Invalid URL") }
        do {
            // perform network request using URLSession
            let (data, _) = try await URLSession.shared.data(from: url)
            // decode response using JSONDecoder()
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let response = try decoder.decode(EventsResponse.self, from: data)
            events = response.events
        } catch {
            print("Failed to fetch events: \(error)")
        }
    }
}
