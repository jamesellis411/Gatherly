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
                Button(action: {
                    // Add functionality later
                }) {
                    Text("Sort by")
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.primary, lineWidth: 2)
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
                        ForEach(vm.filteredEventIndices, id: \.self) { index in
                            NavigationLink {
                                EventDetailView(event: vm.events[index], vm: vm)
                            } label: {
                                EventCardView(event: vm.events[index])
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
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
