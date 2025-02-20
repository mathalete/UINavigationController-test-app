//
//  UINavigationControllerApp.swift
//  UINavigationController
//
//  Created by Peter on 20/02/2025.
//

import SwiftUI

@main
struct NavigationApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarController()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

