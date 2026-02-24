//
//  EditEventView.swift
//  Gatherly
//
//  Created by James Ellis on 2/9/26.
//

import Foundation
import PhotosUI
import SwiftUI

struct EditEventView: View {
    @Environment(\.dismiss) private var dismiss // Dismiss documentation
    @Bindable var vm: EditEventViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading, spacing: 12) {
                // Change Cover Photo Button
                Text("Change Cover Photo")
                    .font(.title2)
                    .fontWeight(.medium)
                HStack {
                    PhotosPicker(selection: $vm.selectedPhoto, matching: .images) {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 35)
                            .padding(20)
                            .background(.thinMaterial)
                    }
                    .task(id: vm.selectedPhoto) {
                        await vm.loadImage()
                    }
                    vm.image?
                        .resizable()
                        .scaledToFit()
                        .frame(height: 75)
                }
            }

            // Event Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Event Title")
                    .font(.title2)
                    .fontWeight(.medium)
                TextField("Enter title here", text: $vm.title, axis: .vertical)
                    .foregroundStyle(.secondary)
                Divider()
                    .overlay(.gray)
            }

            // Location Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Location")
                    .font(.title2)
                    .fontWeight(.medium)
                TextField("Enter Location here", text: $vm.location, axis: .vertical)
                    .foregroundStyle(.secondary)
                Divider()
                    .overlay(.gray)
            }

            // Date and Time Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Date and Time")
                    .font(.title2)
                    .fontWeight(.medium)
                DatePicker("", selection: $vm.timestamp, displayedComponents: [.date, .hourAndMinute])
                    .labelsHidden()
            }

            // Event Description Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Event Description")
                    .font(.title2)
                    .fontWeight(.medium)
                TextField("Enter event description here", text: $vm.description, axis: .vertical)
                    .foregroundStyle(.secondary)
                Divider()
                    .overlay(.gray)
            }

            HStack {
                Spacer()
                Button(action: {
                    Task {
                        do {
                            try await vm.editEvent()
                        } catch {
                            print("Error editing event: \(error)")
                        }
                    }
                }) {
                    Text("Save")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 70)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.cyan, lineWidth: 2)
                        )
                }
                .foregroundStyle(.primary)
                Spacer()
            }
        }
        .padding()
        .navigationTitle("Edit Event")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditEventView(vm: EditEventViewModel(event: Event.example))
            .preferredColorScheme(ColorScheme.dark)
    }
}
