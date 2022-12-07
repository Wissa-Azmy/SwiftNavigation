//
//  SwiftNavigationApp.swift
//  SwiftNavigation
//
//  Created by Wissa.Michael on 24.11.22.
//

import SwiftUI

@main
struct SwiftNavigationApp: App {
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(coordinator: AppCoordinator())
        }
    }
}
