//
//  FullScreenCoverView.swift
//  SwiftNavigation
//
//  Created by Wissa.Michael on 07.12.22.
//

import SwiftUI

struct FullScreenCoverView: View {
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        VStack {
            Text("Full Screen Cover")
            Button("Dismiss") {
                coordinator.dismissFullScreenCover()
            }
            .padding()
        }
    }
}

struct FullScreenCoverView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenCoverView(coordinator: AppCoordinator())
    }
}
