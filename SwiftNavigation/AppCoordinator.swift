//
//  AppCoordinator.swift
//  SwiftNavigation
//
//  Created by Wissa.Michael on 07.12.22.
//

import SwiftUI

protocol Coordinator: ObservableObject {
    var appRoute: [AppRoute] { get set }

    var alert: Alert { get }
    var isShowingAlert: Bool { get set }

    var sheetView: AnyView { get }
    var isShowingSheet: Bool { get set }

    var loadingView: AnyView { get }
    var isLoading: Bool { get set }

    var fullScreenCoverView: AnyView { get }
    var isShowingFullScreenCover: Bool { get set }

    func showSeet(for route: AppRoute)
    func dismissSheet()

    func showFullScreenCover(for route: AppRoute)
    func dismissFullScreenCover()

    func showLoading()
    func stopLoading()

    func navigate(to route: AppRoute)
    func view(for route: AppRoute) -> AnyView
}

class AppCoordinator: Coordinator {
    private var alertTitle = ""
    private var alertMessage = ""
    private var alertButton: AppAlertButton?

    var alert: Alert {
        if let alertButton {
            return Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                primaryButton: alertButton.alertButton,
                secondaryButton: .cancel()
            )
        } else {
            return Alert( title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
    }

    @Published var isShowingAlert = false

    var sheetView = AnyView(EmptyView())

    @Published var isShowingSheet = false

    var loadingView:AnyView { AnyView(LoadingView(coordinator: self)) }

    @Published var isLoading = false

    var fullScreenCoverView = AnyView(EmptyView())

    @Published var isShowingFullScreenCover = false

    @Published var appRoute = [AppRoute]()

    func navigate(to route: AppRoute) {
        appRoute.append(route)
    }

    func view(for route: AppRoute) -> AnyView {
        switch route {
        case .rootView:
            return AnyView(RootView(coordinator: self))
        case .firstScreen:
            return AnyView(Text("First Screen"))
        case .secondScreen:
            return AnyView(Text("Second Screen"))
        case .fullScreenCover:
            return AnyView(FullScreenCoverView(coordinator: self))
        }
    }

    func showAlert(title: String, message: String, primaryButton: AppAlertButton? = nil) {
        alertTitle = title
        alertMessage = message
        alertButton = primaryButton
        isShowingAlert = true
    }

    func showSeet(for route: AppRoute) {
        sheetView = view(for: route)
        isShowingSheet = true
    }

    func dismissSheet() {
        isShowingSheet = false
    }

    func showFullScreenCover(for route: AppRoute) {
        fullScreenCoverView = view(for: route)
        isShowingFullScreenCover = true
    }

    func dismissFullScreenCover() {
        isShowingFullScreenCover = false
    }

    func showLoading() {
        isLoading = true
    }

    func stopLoading() {
        isLoading = false
    }
}


enum AppAlertButton {
    case normal(title: String, action: () -> Void), destructive(title: String, action: () -> Void)

    var alertButton: Alert.Button {
        switch self {
        case .normal(let title, let action):
            return Alert.Button.default(Text(title), action: action)
        case .destructive(let title, let action):
            return Alert.Button.destructive(Text(title), action: action)
        }
    }
}
