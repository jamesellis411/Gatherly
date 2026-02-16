//
//  EditEventView.swift
//  Gatherly
//
//  Created by James Ellis on 2/9/26.
//

import Foundation
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
                HStack(alignment: .center) {
                    Button(action: {
                        // Implement cover photo functionality
                    }) {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .padding(25)
                            .background(.thinMaterial)
                    }
                }
            }

            // Event Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Event Title")
                    .font(.title2)
                    .fontWeight(.medium)
                TextField("", text: $vm.title, axis: .vertical)
                    .foregroundStyle(.secondary)
                Divider()
                    .overlay(.gray)
            }

            // Location Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Location")
                    .font(.title2)
                    .fontWeight(.medium)
                TextField("", text: $vm.location, axis: .vertical)
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
                TextField("", text: $vm.description, axis: .vertical)
                    .foregroundStyle(.secondary)
                Divider()
                    .overlay(.gray)
            }

            HStack {
                Spacer()
                Button(action: {
                    // Put Save Functionality Here
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
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Edit Event")
                    .fontWeight(.semibold)
                    .font(.title2)
            }
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
