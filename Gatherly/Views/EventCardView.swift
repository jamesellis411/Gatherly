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
                .scaledToFill()
                .frame(width: 164, height: 111)

            VStack(alignment: .leading, spacing: 6) {
                Text(event.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text(event.timestamp.formatted(date: .abbreviated, time: .omitted))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(12)
        }
        .frame(width: 164, height: 178)
        .background(.regularMaterial)
        .cornerRadius(11)
    }
}

#Preview {
    EventCardView(event: Event.example)
        .preferredColorScheme(.dark)
}
