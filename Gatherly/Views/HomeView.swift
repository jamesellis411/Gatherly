//
//  HomeView.swift
//  Gatherly
//
//  Created by James Ellis on 2/9/26.
//

import SwiftUI

struct HomeView: View {
    @State private var events: [Event] = []
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(events, id: \.self) { event in
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
                do {
                    events = try await fetchEvents()
                } catch {
                    print("Failed to fetch events")
                }
            }
        }
    }

    func fetchEvents() async throws -> [Event] {
        // define url
        guard let url = URL(string: "https://gatherly-backend-q9vm.onrender.com/events") else { fatalError("Invalid URL") }
        // perform network request using URLSession
        let (data, _) = try await URLSession.shared.data(from: url)
        // decode response using JSONDecoder()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let response = try decoder.decode(EventsResponse.self, from: data)
        return response.events
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
