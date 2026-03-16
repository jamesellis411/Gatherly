//
//  ContentView.swift
//  Gatherly
//
//  Created by James Ellis on 2/5/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            EventMapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
            ProfileView(vm: ProfileViewModel())
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .tint(.cyan)
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
