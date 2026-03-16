//
//  LoadingState.swift
//  Gatherly
//
//  Created by James Ellis on 3/2/26.
//

import Foundation

enum LoadingState {
    case idle
    case loading
    case success
    case failed(ErrorType)
}
