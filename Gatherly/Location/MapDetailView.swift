//
//  MapDetailView.swift
//  Gatherly
//
//  Created by James Ellis on 3/6/26.
//

import Foundation
import SwiftUI

struct MapDetailView: View {
    let event: Event

    var body: some View {
        VStack(spacing: 30) {
            // check to see if event's image_url property is nil since it's an optional
            if let imageEvent = event.image_url {
                // checks to see if image_url is actually a URL
                if let url = URL(string: imageEvent) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        // when loading, it shows spinner (ProgressView())
                        case .empty:
                            ProgressView()
                        // if loads successfully, shows image, sets it to resizable, and is scaled to Fit
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        // if loading the image fails, show gray box
                        case .failure:
                            Rectangle()
                                .foregroundStyle(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .ignoresSafeArea(edges: .horizontal)
                }
            } else {
                // if no image_url property, placeholder is gray box
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 400)
            }

            // Event Details
            VStack(alignment: .leading, spacing: 8) {
                Text(event.title)
                    .font(.title)
                    .fontWeight(.semibold)

                HStack(spacing: 20) {
                    Text(event.timestamp.formatted(date: .abbreviated, time: .omitted))

                    Text("•")

                    Text(event.timestamp.formatted(date: .omitted, time: .shortened))
                }
                .foregroundStyle(.secondary)
                .font(.title3)

                Text(event.location)
                    .foregroundStyle(.secondary)
                    .font(.title3)

                Divider()
                    .overlay(.gray)
            }
            .padding(.horizontal, 10)

            // Event Description
            VStack(alignment: .leading, spacing: 8) {
                Text("Description")
                    .font(.title3)
                Text(event.description)
                    .foregroundStyle(.secondary)
                    .font(.title3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)

            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        MapDetailView(event: Event.example)
            .preferredColorScheme(ColorScheme.dark)
    }
}
