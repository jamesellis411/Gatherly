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
    private var timestampFormatted: String {
        event.timestamp.formatted(.dateTime.month(.abbreviated).day().year())
    }

    var body: some View {
        VStack(alignment: .leading) {
            Image("tempImage")
                .resizable()
                .scaledToFit()

            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.title)

                Text(timestampFormatted)
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
