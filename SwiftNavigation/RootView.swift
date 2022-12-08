//
//  RootView.swift
//  SwiftNavigation
//
//  Created by Wissa.Michael on 07.12.22.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        VStack(spacing: 20) {
            NavigationLink(value: AppRoute.firstScreen) {
                Text("go to first screen from a navigationLink")
            }

            Button("go to second screen from a button") {
                coordinator.navigate(to: .secondScreen)
            }

            Button("Show first screen in a sheet") {
                coordinator.showSeet(for: .firstScreen)
            }

            Button("Show a full screen cover") {
                coordinator.showFullScreenCover(for: .fullScreenCover)
            }

            Button("Show loading") {
                coordinator.showLoading()
            }

            Button("Show alert") {
                coordinator.showAlert(title: "Alert", message: "Can you see me?")
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(coordinator: AppCoordinator())
    }
}
