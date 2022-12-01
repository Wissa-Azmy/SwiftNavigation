//
//  ContentView.swift
//  SwiftNavigation
//
//  Created by Wissa.Michael on 24.11.22.
//

import SwiftUI

enum AppRoute {
    case rootView, firstScreen, secondScreen
}

struct ContentView<GenericCoordinator>: View where GenericCoordinator: Coordinator {
    @ObservedObject var coordinator: GenericCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.appRoute) {
            coordinator.view(for: .rootView)
            .navigationDestination(for: AppRoute.self) { route in
                coordinator.view(for: route)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coordinator: AppCoordinator())
    }
}

protocol Coordinator: ObservableObject {
    var appRoute: [Hashable] { get set }

    func navigate(to route: AppRoute)
    func view(for route: AppRoute) -> AnyView
}

class AppCoordinator: Coordinator {
    @Published var appRoute = [AppRoute]()

    func navigate(to route: AppRoute) {
        appRoute.append(route)
    }

    func view(for route: AppRoute) -> AnyView {
        switch route {
        case .rootView:
            return AnyView(RootScreen(coordinator: self))
        case .firstScreen:
            return AnyView(Text("First Screen generic"))
        case .secondScreen:
            return AnyView(Text("second Screen"))
        }
    }
}

struct RootScreen: View {
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        VStack {
            NavigationLink(value: AppRoute.firstScreen) {
                Text("go to first screen")
            }

            Button("go to second screen") {
                coordinator.navigate(to: .secondScreen)
            }
        }
    }
}
