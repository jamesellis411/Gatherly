//
//  EventService.swift
//  Gatherly
//
//  Created by James Ellis on 2/23/26.
//

import Foundation
import Observation
import UIKit

@Observable
class EventService {
    static let shared: EventService = .init()
    let baseURL: URL = .init(string: "https://gatherly-backend-q9vm.onrender.com/")!

    func createEvent(title: String, description: String, timestamp: Date, location: String, uiImage: UIImage? = nil) async throws -> Event? {
        let path = baseURL.appending(path: "events")
        var imageString = ""
        if let image = uiImage, let data = image.jpegData(compressionQuality: 0.8) {
            imageString = "data:image/jpeg;base64,\(data.base64EncodedString())"
        }

        var request = URLRequest(url: path)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = Event(title: title, location: location, description: description, timestamp: timestamp, image: imageString)
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        request.httpBody = try encoder.encode(body)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            print("Failed to create event")
            return nil
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Event.self, from: data)
    }

    func editEvent(id: String, title: String, description: String, timestamp: Date, location: String, uiImage: UIImage? = nil) async throws {
        let path = baseURL.appending(path: "events/\(id)")
        var imageString = ""
        if let image = uiImage, let data = image.jpegData(compressionQuality: 0.8) {
            imageString = "data:image/jpeg;base64,\(data.base64EncodedString())"
        }

        var request = URLRequest(url: path)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = Event(title: title, location: location, description: description, timestamp: timestamp, image: imageString)
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        request.httpBody = try encoder.encode(body)

        let (_, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            print("Event updated successfully!")
        } else {
            print("Error updating event!")
        }
    }

    func deleteEvent(id: String) async throws {
        // Define URL
        let path = baseURL.appending(path: "events/\(id)")

        // Create URLRequest and set its method
        var request = URLRequest(url: path)
        request.httpMethod = "DELETE"

        // Create and encode a request body
        let body = ["creatorPid", "730739772"]
        let encoder = JSONEncoder()
        let data = try? encoder.encode(body)

        // Set headers
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Perform request using URLSession
        let (_, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            print("Event successfully deleted!")
        } else {
            print("Error deleting event!")
        }
    }
}
