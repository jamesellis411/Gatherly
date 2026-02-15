//
//  HomeView.swift
//  Gatherly
//
//  Created by James Ellis on 2/9/26.
//

import SwiftUI

struct HomeView: View {
    @State private var vm = EventsViewModel()
    let columns = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 22) {
                    ForEach(vm.events, id: \.self) { event in
                        NavigationLink {
                            EventDetailsView(event: event)
                        } label: {
                            EventCardView(event: event)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(18)
            }
            .task {
                await vm.fetchEvents()
            }
        }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
