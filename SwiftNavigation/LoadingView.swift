//
//  LoadingView.swift
//  SwiftNavigation
//
//  Created by Wissa.Michael on 08.12.22.
//

import SwiftUI

struct LoadingView: View {
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture { coordinator.stopLoading() }
            VStack {
                ProgressView()
                    .padding()
                Text("Loading...")
                    .fontWeight(.bold)
            }
            .frame(width: 150, height: 150)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(coordinator: AppCoordinator())
    }
}
