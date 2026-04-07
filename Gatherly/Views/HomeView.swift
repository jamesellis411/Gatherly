//
//  HomeView.swift
//  Gatherly
//
//  Created by James Ellis on 2/9/26.
//

import SwiftUI

struct HomeView: View {
    @State private var vm = EventViewModel()
    let columns = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]

    var body: some View {
        NavigationStack {
            HStack {
                Menu {
                    Button("Alphabetical") { vm.sortOption = .alphabetical }
                    Button("Upcoming") { vm.sortOption = .upcoming }
                    Button("None") { vm.sortOption = .none }
                } label: {
                    Text("Sort By")
                        .padding(8)
                        .buttonStyle(.plain)
//                        .foregroundStyle(.secondary)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.primary, lineWidth: 1)
                        )
                }

                Spacer()
                NavigationLink {
                    AddEventView(vm: AddEventViewModel())
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "plus")
                        Text("Create Event")
                    }
                    .foregroundStyle(.primary)
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 8)
            .buttonStyle(.plain)

            switch vm.loadingState {
            case .loading:
                ProgressView("Loading events...")
            case .failed(let errorType):
                ContentUnavailableView {
                    Label("Something went wrong", systemImage: "x.circle.fill")
                } description: {
                    Text(errorType.localizedDescription)
                }
            case .idle, .success:
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 22) {
                        ForEach(vm.filteredAndSortedEvents, id: \.self) { event in
                            NavigationLink {
                                EventDetailView(event: event, vm: vm)
                            } label: {
                                EventCardView(event: event)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 18)
                .searchable(text: $vm.searchText, placement: .navigationBarDrawer(displayMode: .always))
            }
        }
        .task {
            await vm.fetchEvents()
        }
        .alert(vm.errorString, isPresented: $vm.isError) {
            Button("Try Again") {
                Task { await vm.fetchEvents() }
            }
            Button("Cancel", role: .cancel) {}
        }
        .refreshable {
            await vm.fetchEvents()
        }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
