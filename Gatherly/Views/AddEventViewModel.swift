//
//  AddEventViewModel.swift
//  Gatherly
//
//  Created by James Ellis on 2/14/26.
//

import Foundation
import Observation
import PhotosUI
import SwiftUI

@Observable
class AddEventViewModel {
    var id: String?
    var creatorPid: String = "730739772"
    var title: String = ""
    var location: String = ""
    var description: String = ""
    var timestamp: Date = .init()

    var base64String: String?
    var uiImage: UIImage?
    var image: Image? {
        if let uiImage = uiImage {
            return Image(uiImage: uiImage)
        }
        return nil
    }

    var selectedPhoto: PhotosPickerItem?
    var createdEvent: Event?
    
    var loadingState: LoadingState = .idle

    func loadImage() async {
        loadingState = .loading
        do {
            if let data = try await selectedPhoto?.loadTransferable(type: Data.self) {
                let uiImage = UIImage(data: data)
                self.uiImage = uiImage
                loadingState = .success
            }
        } catch let error as ErrorType{
            loadingState = .failed(error)
        } catch {
            loadingState = .failed(.unknown)
        }
    }

    func createEvent() async throws {
        createdEvent = try await EventService.shared.createEvent(title: title,
                                                                 description: description,
                                                                 timestamp: timestamp,
                                                                 location: location,
                                                                 uiImage: uiImage)
    }
}
