//
//  ProfileEventCardView.swift
//  Gatherly
//
//  Created by James Ellis on 3/20/26.
//

import Foundation
import SwiftUI

struct ProfileEventCardView: View {
    let event: Event

    var body: some View {
        HStack {
            // check to see if event's image_url property is nil since it's an optional
            if let imageEvent = event.image_url {
                // checks to see if image_url is actually a URL
                if let url = URL(string: imageEvent) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        // when loading, it shows spinner (ProgressView())
                        case .empty:
                            ProgressView()
                                .frame(width: 80, height: 81)
                                .cornerRadius(10)
                        // if loads successfully, shows image, sets it to resizable, and is scaled to Fit
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 81)
                                .cornerRadius(10)
                        // if loading the image fails, show gray box
                        case .failure:
                            Rectangle()
                                .foregroundStyle(.gray)
                                .frame(width: 80, height: 81)
                                .cornerRadius(10)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            } else {
                // if no image_url property, placeholder is gray box
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(width: 80, height: 81)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text(event.timestamp.formatted(date: .abbreviated, time: .omitted))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(event.location)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thickMaterial)
        .cornerRadius(10)
        .padding(20)

    }
}

#Preview {
    ProfileEventCardView(event: Event.example)
}
