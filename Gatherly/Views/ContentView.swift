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
                }
            ProfileView(vm: ProfileViewModel())
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}

// Ticket 1 finished!
