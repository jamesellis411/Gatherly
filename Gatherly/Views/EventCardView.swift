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
//            Image("tempImage") // Change later to load image from URL
//                .resizable()
//                .scaledToFill()
//                .frame(width: 164, height: 111)

            // check to see if event's image_url property is nil since it's an optional
            if let imageEvent = event.image_url {
                // checks to see if image_url is actually a URL
                if let url = URL(string: imageEvent) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        // when loading, it shows spinner (ProgressView())
                        case .empty:
                            ProgressView()
                                .frame(width: 164, height: 111)
                        // if loads successfully, shows image, sets it to resizable, and is scaled to Fit
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 164, height: 111)
                                .clipped()
                        // if loading the image fails, show gray box
                        case .failure:
                            Rectangle()
                                .foregroundStyle(.gray)
                                .frame(width: 164, height: 111)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            } else {
                // if no image_url property, placeholder is gray box
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(width: 164, height: 111)
            }

            VStack(alignment: .leading, spacing: 4) {
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
