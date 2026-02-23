//
//  ProfileView.swift
//  Gatherly
//
//  Created by James Ellis on 2/15/26.
//

import Foundation
import PhotosUI
import SwiftUI

struct ProfileView: View {
    @State private var selectedPhoto: PhotosPickerItem?
    @Bindable var vm: ProfileViewModel
    var body: some View {
        VStack {
            // PhotosPicker and Name
            HStack {
                VStack(spacing: 12) {
                    PhotosPicker(selection: $selectedPhoto, matching: .images) {
                        Circle()
                            .foregroundStyle(.regularMaterial)
                            .frame(width: 107, height: 107)
                            .overlay(
                                Image(systemName: "plus")
                                    .foregroundStyle(.cyan)
                                    .font(.system(size: 45))
                            )
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
        }
    }
}

#Preview {
    ProfileView(vm: ProfileViewModel())
        .preferredColorScheme(.dark)
}
