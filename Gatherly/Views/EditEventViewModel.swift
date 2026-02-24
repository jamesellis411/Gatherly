//
//  EditEventViewModel.swift
//  Gatherly
//
//  Created by James Ellis on 2/14/26.
//

import Foundation
import Observation
import PhotosUI
import SwiftUI

@Observable
class EditEventViewModel {
    var id: String?
    var creatorPid: String
    var title: String
    var location: String
    var description: String
    var timestamp: Date
    var image_url: String?

    var base64String: String?
    var uiImage: UIImage?
    var image: Image? {
        if let uiImage = uiImage {
            return Image(uiImage: uiImage)
        }
        return nil
    }

    var selectedPhoto: PhotosPickerItem?

    init(event: Event) {
        self.id = event.id
        self.creatorPid = event.creatorPid
        self.title = event.title
        self.location = event.location
        self.description = event.description
        self.timestamp = event.timestamp
        self.image_url = event.image_url
    }

    func loadImage() async {
        if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
            let uiImage = UIImage(data: data)
            self.uiImage = uiImage
        }
    }

    func editEvent() async throws {
        try await EventService.shared.editEvent(id: id!, title: title, description: description, timestamp: timestamp, location: location)
    }
}
