//
//  ProfileView.swift
//  Gatherly
//
//  Created by James Ellis on 2/15/26.
//

import Foundation
import PhotosUI
import SwiftData
import SwiftUI

struct ProfileView: View {
    @Bindable var vm: ProfileViewModel
    @Query var upcomingEvents: [RSVPedEvent]
    @Query var pastEvents: [RSVPedEvent]

    /// Build queries at runtime to use Date.now and accept a view model
    init(vm: ProfileViewModel) {
        self.vm = vm

        let now = Date.now
        _upcomingEvents = Query(
            filter: #Predicate { event in
                event.timestamp >= now
            }
        )
        _pastEvents = Query(
            filter: #Predicate { event in
                event.timestamp < now
            }
        )
    }

    var body: some View {
        VStack {
            // PhotosPicker and Name
            HStack {
                VStack(spacing: 12) {
                    PhotosPicker(selection: $vm.selectedPhoto, matching: .images) {
                        Circle()
                            .foregroundStyle(.regularMaterial)
                            .frame(width: 107, height: 107)
                            .overlay(
                                Group { // have to use Group in .overlay() to resolve if/else logic into a singular view per documentation
                                    if let image = vm.image { // vm.image set or nil
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                    } else {
                                        Image(systemName: "plus")
                                            .foregroundStyle(.cyan)
                                            .font(.largeTitle)
                                    }
                                }
                            )
                    }
                    .onChange(of: vm.selectedPhoto) { // use onChange to trigger call to vm
                        Task {
                            await vm.loadImage()
                        }
                    }

                    Text("James Ellis") // Hardcoded for now
                        .fontWeight(.semibold)
                }
            }

            // Profile Tabs
            HStack(spacing: 0) {
                ForEach(vm.tabs, id: \.self) { tab in
                    Button {
                        vm.selectTab(tab: tab)
                    } label: {
                        VStack {
                            Text(tab)
                                .foregroundStyle(.primary)
                                .fontWeight(.semibold)
                            Rectangle()
                                .fill(vm.selectedTab == tab ? .cyan : .primary)
                                .frame(height: 2)
                                .padding(.top, 4)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()

            ScrollView {
                LazyVStack(spacing: 10) {
                    if vm.selectedTab == "RSVP'd" {
                        ForEach(upcomingEvents, id: \.id) { event in
                            ProfileEventCardView(event: Event(
                                id: event.id,
                                creatorPid: event.creatorPid,
                                title: event.title,
                                location: event.location,
                                description: event.eventDescription,
                                timestamp: event.timestamp,
                                image_url: event.image_url
                            ))
                            .padding(.horizontal, 16)
                        }
                    } else if vm.selectedTab == "Past Events" {
                        ForEach(pastEvents, id: \.id) { event in
                            ProfileEventCardView(event: Event(
                                id: event.id,
                                creatorPid: event.creatorPid,
                                title: event.title,
                                location: event.location,
                                description: event.eventDescription,
                                timestamp: event.timestamp,
                                image_url: event.image_url
                            ))
                            .padding(.horizontal, 16)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView(vm: ProfileViewModel())
        .preferredColorScheme(.dark)
}
