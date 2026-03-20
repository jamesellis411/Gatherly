//
//  ProfileViewModel.swift
//  Gatherly
//
//  Created by James Ellis on 2/15/26.
//

import Foundation
import Observation
import PhotosUI
import SwiftUI
import SwiftData

@Observable
class ProfileViewModel {
    let tabs = ["RSVP'd", "Past Events"]
    var selectedTab: String = "RSVP'd"
    var loadingState: LoadingState = .idle

    func selectTab(tab: String) {
        selectedTab = tab
        filterEvents()
    }

    func filterEvents() {
        // Implement functionality later
    }
    
    var selectedPhoto: PhotosPickerItem?
    var createdEvent: Event?
    
    var base64String: String?
    var uiImage: UIImage?
    var image: Image? {
        if let uiImage = uiImage {
            return Image(uiImage: uiImage)
        }
        return nil
    }

    func loadImage(profile: UserProfile, modelContext: ModelContext) async {
        loadingState = .loading
        do {
            if let data = try await selectedPhoto?.loadTransferable(type: Data.self) {
                let uiImage = UIImage(data: data)
                self.uiImage = uiImage
                profile.imageData = data
                try? modelContext.save()
            }
            loadingState = .success
        } catch let error as ErrorType {
            loadingState = .failed(error)
        } catch {
            loadingState = .failed(.unknown)
        }
    }
}
