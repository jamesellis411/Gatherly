//
//  AddEventView.swift
//  Gatherly
//
//  Created by James Ellis on 2/14/26.
//

import Foundation
import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss) private var dismiss // Dismiss documentation
    @Bindable var vm: AddEventViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading, spacing: 12) {
                // Change Cover Photo Button
                Text("Upload Cover Photo")
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
                TextField("Write your event's title", text: $vm.title, axis: .vertical)
                Divider()
                    .overlay(.gray)
            }

            // Location Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Location")
                    .font(.title2)
                    .fontWeight(.medium)
                TextField("Choose location of event", text: $vm.location, axis: .vertical)
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
                TextField("Write a description for your event", text: $vm.description, axis: .vertical)
                Divider()
                    .overlay(.gray)
            }

            HStack {
                Spacer()
                Button(action: {
                    // Put Create Functionality Here
                }) {
                    Text("Create Event")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 40)
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
        .navigationTitle("Create Event")
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
        AddEventView(vm: AddEventViewModel())
            .preferredColorScheme(ColorScheme.dark)
    }
}
