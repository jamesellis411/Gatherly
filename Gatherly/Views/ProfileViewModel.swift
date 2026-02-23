//
//  ProfileViewModel.swift
//  Gatherly
//
//  Created by James Ellis on 2/15/26.
//

import Foundation
import Observation

@Observable
class ProfileViewModel {
    let tabs = ["RSVP'd", "Past Events"]
    var selectedTab: String = "RSVP'd"

    func selectTab(tab: String) {
        selectedTab = tab
        filterEvents()
    }

    func filterEvents() {
        // Implement functionality later
    }
}
