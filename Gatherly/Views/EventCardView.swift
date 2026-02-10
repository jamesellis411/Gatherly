//
//  EventCardView.swift
//  Gatherly
//
//  Created by James Ellis on 2/5/26.
//

import Foundation
import SwiftUI

struct EventCardView: View {
    let event: Event

    var body: some View {
        VStack(alignment: .leading) {
            Image("tempImage") // Change later to load image from URL
                .resizable()
                .scaledToFit()

            VStack(alignment: .leading, spacing: 10) {
                Text(event.title)
                    .font(.title)

                Text(event.timestamp.formatted(date: .abbreviated, time: .omitted))
                    .font(.title)
                    .foregroundStyle(.secondary)
            }
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 20, trailing: 16))
        }
        .background(.regularMaterial)
        .cornerRadius(11)
    }
}

#Preview {
    EventCardView(event: Event.example)
        .preferredColorScheme(.dark)
}
