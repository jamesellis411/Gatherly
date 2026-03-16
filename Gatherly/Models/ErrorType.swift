//
//  ErrorType.swift
//  Gatherly
//
//  Created by James Ellis on 3/2/26.
//
import Foundation

enum ErrorType: LocalizedError {
    case networkError
    case codingError
    case invalidURL
    case geocodeError
    case unknown

    var errorDescription: String? {
        switch self {
        case .networkError:
            return "A network error occurred. Please check your connection."
        case .codingError:
            return "Failed to encode/decode data."
        case .invalidURL:
            return "The URL provided is invalid."
        case .geocodeError:
            return "Failed to geocode addresses."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
