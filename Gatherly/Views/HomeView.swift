//
//  HomeView.swift
//  Gatherly
//
//  Created by James Ellis on 2/9/26.
//

import SwiftUI

struct HomeView: View {
    @State private var vm = EventsViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(vm.events, id: \.self) { event in
                        NavigationLink {
                            EventDetailsView(event: event)
                        } label: {
                            EventCardView(event: event)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
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
