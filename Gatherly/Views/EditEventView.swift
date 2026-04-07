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
    let event: Event

    var body: some View {
        VStack {
            switch vm.loadingState {
            case .loading:
                ProgressView("Editing event...")
            case .failed(let error):
                ContentUnavailableView {
                    Label("Something went wrong", systemImage: "x.circle.fill")
                } description: {
                    Text(error.localizedDescription)
                }
            case .idle, .success:
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
                            
                            // Prioritize newly selected photo
                            if let image = vm.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 75)
                                    .clipped()
                            } else if let imageEvent = event.image_url { // check to see if event's image_url property is nil since it's an optional
                                // checks to see if image_url is actually a URL
                                if let url = URL(string: imageEvent) {
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        // when loading, it shows spinner (ProgressView())
                                        case .empty:
                                            ProgressView()
                                            
                                        // if loads successfully, shows image, sets it to resizable, and is scaled to fill
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 75, height: 75)
                                                .clipped()
                                        // if loading the image fails, show gray box
                                        case .failure:
                                            Rectangle()
                                            .foregroundStyle(.gray)
                                            .scaledToFit()
                                            .frame(height: 75)
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                }
                            } else {
                                // if no image_url property, placeholder is gray box
                                Rectangle()
                                    .foregroundStyle(.gray)
                                    .scaledToFit()
                                    .frame(height: 75)
                            }
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
                                    await vm.editEvent()
                                    if case .success = vm.loadingState {
                                        dismiss()
                                    }
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
        .task(id: vm.selectedPhoto) {
            await vm.loadImage()
        }
        .alert(vm.errorString, isPresented: $vm.isError){
            Button("Try Again") {
                Task {
                    await vm.editEvent()
                }
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

#Preview {
    NavigationStack {
        EditEventView(vm: EditEventViewModel(event: Event.example), event: Event.example)
            .preferredColorScheme(ColorScheme.dark)
    }
}
