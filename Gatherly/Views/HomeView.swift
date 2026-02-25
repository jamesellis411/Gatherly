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
            ScrollView {
                HStack {
                    Button(action: {
                        // Add functionality later
                    }) {
                        Text("Sort by")
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.white, lineWidth: 2)
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
                .padding(7)
                .foregroundStyle(.white)

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
            .task {
                do {
                    vm.events = try await vm.fetchEvents()
                } catch {
                    print("there was an error: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
