//
//  EventMapView.swift
//  Gatherly
//
//  Created by James Ellis on 3/6/26.
//
import MapKit
import SwiftUI

struct EventMapView: View {
    @State private var vm = EventsMapViewModel()
    @State private var position = MapCameraPosition.automatic
    @State private var selectedEvent: Event?

    @State private var mapType: MapStyle = .hybrid
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.904613, longitude: -79.046761),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        MapReader { _ in
            Map(position: $position) {
                ForEach(vm.annotations) { annotation in
                    Annotation(annotation.event.title, coordinate: annotation.coordinate) {
                        Button {
                            selectedEvent = annotation.event
                        } label: {
                            Image(systemName: "mappin")
                                .font(.largeTitle)
                                .foregroundStyle(.cyan)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .task {
                do {
                    try await vm.load()
                } catch {
                    print("Failed to geocode addresses: \(error.localizedDescription)")
                }
            }
            .alert("Error", isPresented: $vm.isError) {
                Button("Try Again") {
                    Task { try await vm.load() }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text(vm.errorString)
            }
            .sheet(item: $selectedEvent) { event in
                MapDetailView(event: event)
            }
            .overlay(alignment: .topLeading) {
                Button {
                    vm.showOnlyMyEvents.toggle()
                    Task {
                        try await vm.load()
                    }
                } label: {
                    Text(vm.showOnlyMyEvents ? "Show All Events" : "Show Only My Events")
                        .padding(8)
                        .background(.regularMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.primary, lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                .padding(.leading)
            }
        }
    }
}

#Preview {
    EventMapView()
}
