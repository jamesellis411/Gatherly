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
                    .font(.title)

                HStack(alignment: .center) {
                    Button(action: {
                        // Implement cover photo functionality
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 45))
                            .frame(width: 100, height: 100)
                            .background(
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray).opacity(0.3)
                            )
                    }
                }
            }

            // Event Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Event Title")
                    .font(.title)
                TextField("", text: $vm.title, axis: .vertical)
                Divider()
                    .frame(height: 1)
                    .overlay(.gray)
            }

            // Location Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Location")
                    .font(.title)
                TextField("", text: $vm.location, axis: .vertical)
                Divider()
                    .frame(height: 1)
                    .overlay(.gray)
            }

            // Date and Time Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Date and Time")
                    .font(.title)
                DatePicker("", selection: $vm.timestamp, displayedComponents: [.date, .hourAndMinute])
                    .labelsHidden() // Ask for clarification on why "" didn't remove section?
            }

            // Event Description Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Event Description")
                    .font(.title)
                TextField("", text: $vm.description, axis: .vertical)
                Divider()
                    .frame(height: 1)
                    .overlay(.gray)
            }

            HStack {
                Spacer()
                Button(action: {
                    // Put Save Functionality Here
                }) {
                    Text("Save")
                        .font(.title)
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
//            .preferredColorScheme(ColorScheme.dark)
    }
}
