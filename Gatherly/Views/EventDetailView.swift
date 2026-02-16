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

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Image("tempImage")
                .resizable()
                .scaledToFit()

            // Event Details
            VStack(alignment: .leading, spacing: 12) {
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
            VStack(alignment: .leading, spacing: 12) {
                Text("Description")
                    .font(.title3)
                Text(event.description)
                    .foregroundStyle(.secondary)
                    .font(.title3)
            }
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
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Event Details")
                    .fontWeight(.semibold)
                    .font(.title2)
            }
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
                EditEventView(vm: EditEventViewModel(event: event))
            }
            Button("Delete Event", role: .destructive) {
                // Delete action
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
        EventDetailView(event: Event.example)
            .preferredColorScheme(ColorScheme.dark)
    }
}
