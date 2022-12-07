//
//  AppCoordinatorView.swift
//  SwiftNavigation
//
//  Created by Wissa.Michael on 24.11.22.
//

import SwiftUI

enum AppRoute {
    case rootView, firstScreen, secondScreen, fullScreenCover
}

struct AppCoordinatorView<GenericCoordinator>: View where GenericCoordinator: Coordinator {
    @ObservedObject var coordinator: GenericCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.appRoute) {
            coordinator.view(for: .rootView)
            .navigationDestination(for: AppRoute.self) { route in
                coordinator.view(for: route)
            }
        }
        .overlay {
            if coordinator.isLoading {
                coordinator.loadingView
            }
        }

        .sheet(isPresented: $coordinator.isShowingSheet) {
            coordinator.sheetView
        }

        .alert(isPresented: $coordinator.isShowingAlert) {
            coordinator.alert
        }

        .fullScreenCover(isPresented: $coordinator.isShowingFullScreenCover) {
            coordinator.fullScreenCoverView
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppCoordinatorView(coordinator: AppCoordinator())
    }
}
