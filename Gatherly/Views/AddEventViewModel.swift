//
//  AddEventViewModel.swift
//  Gatherly
//
//  Created by James Ellis on 2/14/26.
//

import Foundation
import Observation

@Observable
class AddEventViewModel {
    var id: String?
    var creatorPid: String = "730739772"
    var title: String = ""
    var location: String = ""
    var description: String = ""
    var timestamp: Date = Date()
    var image_url: String?
    var image: String?

    init() {}
}
