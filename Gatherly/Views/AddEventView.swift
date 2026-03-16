//
//  AddEventView.swift
//  Gatherly
//
//  Created by James Ellis on 2/14/26.
//

import Foundation
import PhotosUI
import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss) private var dismiss // Dismiss documentation
    @Bindable var vm: AddEventViewModel

    var body: some View {
        VStack {
            switch vm.loadingState {
            case .loading:
                ProgressView("Creating event...")
            case .failed(let error):
                ContentUnavailableView{
                    Label("Something went wrong", systemImage: "x.circle.fill")
                } description: {
                    Text(error.localizedDescription)
                }
            case .idle, .success:
                VStack(alignment: .leading, spacing: 32) {
                    VStack(alignment: .leading, spacing: 12) {
                        // Change Cover Photo Button
                        Text("Upload Cover Photo")
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
                            vm.image?
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipped()
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
                            Task {
                                do {
                                    await vm.createEvent()
                                    if case .success = vm.loadingState {
                                        dismiss() // On success, dismiss view, returning to HomeView
                                    }
                                }
                            }
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
        .task(id: vm.selectedPhoto) {
            await vm.loadImage()
        }
        .alert(vm.errorString, isPresented: $vm.isError) {
            Button("Try Again") {
                Task {
                    await vm.createEvent()
                }
            }
            Button("Cancel", role: .cancel){}
        }
    }
}

#Preview {
    NavigationStack {
        AddEventView(vm: AddEventViewModel())
            .preferredColorScheme(ColorScheme.dark)
    }
}
