//
//  EventsMapViewModel.swift
//  Gatherly
//
//  Created by James Ellis on 3/6/26.
//
import CoreLocation
import Foundation
import Observation

@Observable
class EventsMapViewModel {
    var events: [Event] = []
    var annotations: [EventAnnotation] = []
    private let geocoder = CLGeocoder()
    
    var showOnlyMyEvents: Bool = false
    
    var errorString: String = ""
    var isError: Bool = false
    
    func load() async throws {
        do {
            let response = try await EventService.shared.fetchEvents()
            events = response
                
            let addressEvents = response.filter { !$0.location.isEmpty }
            let filteredEvents = showOnlyMyEvents ? addressEvents.filter { $0.creatorPid == "730739772"} : addressEvents
                                
            annotations.removeAll()
            for event in filteredEvents {
                if let coordinate = try await geocode(event.location) {
                    annotations.append(EventAnnotation(id: event.id ?? UUID().uuidString,
                                                       event: event,
                                                       coordinate: coordinate))
                }
            }
        } catch {
            throw ErrorType.geocodeError
        }
    }
    
    private func geocode(_ address: String) async throws -> CLLocationCoordinate2D? {
        await withCheckedContinuation { continuation in
            geocoder.geocodeAddressString(address) { place, _ in
                let coordinate = place?.first?.location?.coordinate
                continuation.resume(returning: coordinate)
            }
        }
    }
}
