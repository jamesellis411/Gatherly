//
//  EditEventViewModel.swift
//  Gatherly
//
//  Created by James Ellis on 2/14/26.
//

import Foundation
import Observation

@Observable
class EditEventViewModel {
    var event: Event

    init(event: Event) {
        self.event = event
    }
}
