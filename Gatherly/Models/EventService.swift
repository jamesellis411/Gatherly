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
    static let shared = try! EventService() // force-unwrap bc init only throws once
    private let baseURL: URL
    private init() throws {
        guard let url = URL(string: "https://gatherly-backend-q9vm.onrender.com/") else {
            throw ErrorType.invalidURL
        }
        self.baseURL = url
    }
    
    func fetchEvents() async throws -> [Event] {
        do {
            // perform network request using URLSession
            guard let path = URL(string: "\(baseURL)events") else {
                throw ErrorType.invalidURL
            }
            let (data, _) = try await URLSession.shared.data(from: path)
            
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

    func createEvent(title: String, description: String, timestamp: Date, location: String, uiImage: UIImage? = nil) async throws -> Event? {
        guard let path = URL(string: "\(baseURL)events") else {
            throw ErrorType.invalidURL
        }
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
        do {
            request.httpBody = try encoder.encode(body)
        } catch {
            throw ErrorType.codingError
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ErrorType.networkError
            }
            
            guard httpResponse.statusCode == 201 else {
                throw ErrorType.networkError
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            do {
                return try decoder.decode(Event.self, from: data)
            } catch {
                throw ErrorType.codingError
            }
        } catch is URLError {
            throw ErrorType.networkError
        } catch {
            throw ErrorType.unknown
        }
    }

    func editEvent(id: String, title: String, description: String, timestamp: Date, location: String, uiImage: UIImage? = nil) async throws {
        guard let path = URL(string: "\(baseURL)events/\(id)") else {
            throw ErrorType.invalidURL
        }
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
        do {
            request.httpBody = try encoder.encode(body)
        } catch {
            throw ErrorType.codingError
        }
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ErrorType.networkError
            }
            
            guard httpResponse.statusCode == 200 else {
                throw ErrorType.networkError
            }
        } catch is URLError {
            throw ErrorType.networkError
        } catch {
            throw ErrorType.unknown
        }
    }

    func deleteEvent(id: String) async throws {
        // Define URL
        guard let path = URL(string: "\(baseURL)events/\(id)") else {
            throw ErrorType.invalidURL
        }

        // Create URLRequest and set its method
        var request = URLRequest(url: path)
        request.httpMethod = "DELETE"

        // Create and encode a request body
        let body = ["creatorPid": "730739772"]
        let encoder = JSONEncoder()
        
        do {
            guard let data = try? encoder.encode(body) else {
                throw ErrorType.codingError
            }
            // Set headers
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Perform request using URLSession
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ErrorType.networkError
            }
            
            guard httpResponse.statusCode == 200 else {
                throw ErrorType.networkError
            }
        } catch is URLError {
            throw ErrorType.networkError
        } catch {
            throw ErrorType.unknown
        }
    }
    
    func fetchEvent(id: String) async throws -> Event {
        do {
            // perform network request using URLSession
            guard let path = URL(string: "\(baseURL)events/\(id)") else {
                throw ErrorType.invalidURL
            }
            let (data, _) = try await URLSession.shared.data(from: path)
            
            // decode response using JSONDecoder()
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            guard let event = try? decoder.decode(Event.self, from: data) else {
                throw ErrorType.codingError
            }
            return event
        } catch is URLError {
            throw ErrorType.networkError
        } catch {
            throw ErrorType.unknown
        }
    }
}
