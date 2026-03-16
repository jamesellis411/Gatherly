//
//  EventDetailsView.swift
//  Gatherly
//
//  Created by James Ellis on 2/6/26.
//

import Foundation
import SwiftUI

struct EventDetailView: View {
    let event: Event
    @Environment(\.dismiss) private var dismiss // Syntax for dismiss action in back button
    @State private var isShowingDialog = false
    @Bindable var vm: EventViewModel

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

            HStack {
                Spacer()
                Button(action: {
                    // Put RSVP functionality here
                }) {
                    Text("RSVP")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 48)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.cyan, lineWidth: 2)
                        )
                }
                .foregroundStyle(.primary)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Event Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isShowingDialog = true
                }) {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .confirmationDialog("Advanced Actions", isPresented: $isShowingDialog, titleVisibility: .visible) {
            NavigationLink("Edit Event") {
                EditEventView(vm: EditEventViewModel(event: event), event: event)
            }
            Button("Delete Event", role: .destructive) {
                Task {
                    do {
                        try await vm.deleteEvent(id: event.id!)
                    }
                }
            }
            Button("Cancel", role: .cancel) {
                isShowingDialog = false
            }
        } message: {
            Text("Make changes to your event")
        }
    }
}

#Preview {
    NavigationStack {
        EventDetailView(event: Event.example, vm: EventViewModel())
            .preferredColorScheme(ColorScheme.dark)
    }
}
