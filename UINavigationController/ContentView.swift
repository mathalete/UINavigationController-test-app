//
//  ContentView.swift
//  UINavigationController
//
//  Created by Peter on 20/02/2025.
//

import SwiftUI
import UIKit

struct HomeView: View {
    @State private var isReduceTransparency: Bool = UIAccessibility.isReduceTransparencyEnabled
    @State private var isHighContrast: Bool = UIAccessibility.isDarkerSystemColorsEnabled

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("UITabController test app")
                        .font(.largeTitle)
                        .padding(.bottom, 10)
                    
                    // Live Accessibility Status
                    featureStatus(
                        title: "Reduce Transparency",
                        value: isReduceTransparency ? "Enabled ✅" : "Disabled ❌"
                    )
                    
                    featureStatus(
                        title: "Increase Contrast",
                        value: isHighContrast ? "Enabled ✅" : "Disabled ❌"
                    )

                    featureDescription(
                        title: "Reduce transparency",
                        description: "The UITabBarController dynamically adjusts its background based on the user's accessibility settings. If 'Reduce Transparency' is enabled, the tab bar switches to a solid background for better readability. Otherwise, it maintains a subtle transparency effect."
                    )
                    
                    featureDescription(
                        title: "Increase contrast",
                        description: "The tab bar listens for the 'Increase Contrast' setting and adjusts the SF Symbol fill colours to be darker if the setting is enabled. This ensures that icons and selected states remain highly visible under different contrast preferences."
                    )

                    
                    // Placeholder Image
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                    
                    Text("Try enabling 'Reduce Transparency' or 'Increase Contrast' in iOS Settings to see the changes.")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.top, 10)
                }
                .padding()
            }
            .navigationTitle("Home")
            .onAppear(perform: setupAccessibilityObserver)
        }
    }
    
    // MARK: - Observe Accessibility Changes
    private func setupAccessibilityObserver() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(forName: UIAccessibility.reduceTransparencyStatusDidChangeNotification, object: nil, queue: .main) { _ in
            self.isReduceTransparency = UIAccessibility.isReduceTransparencyEnabled
        }

        notificationCenter.addObserver(forName: UIAccessibility.darkerSystemColorsStatusDidChangeNotification, object: nil, queue: .main) { _ in
            self.isHighContrast = UIAccessibility.isDarkerSystemColorsEnabled
        }
    }
    
    // MARK: - Feature Description View
    private func featureDescription(title: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
    }

    // MARK: - Accessibility Status View
    private func featureStatus(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            
            Text(value)
                .font(.body)
                .foregroundColor(value.contains("Enabled") ? .green : .red)
                .bold()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
// MARK: - Music Tab
struct MusicView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Music Library")
                        .font(.largeTitle)
                        .padding()

                    ForEach(1...20, id: \.self) { i in
                        Text("Music Content \(i)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(10)
                    }
                    
                    Image(systemName: "music.note.list")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.green)
                }
                .padding()
            }
            .navigationTitle("Music")
        }
    }
}

// MARK: - Podcasts Tab
struct PodcastsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Podcasts")
                        .font(.largeTitle)
                        .padding()

                    ForEach(1...20, id: \.self) { i in
                        Text("Podcast Episode \(i)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(10)
                    }
                    
                    Image(systemName: "mic.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.red)
                }
                .padding()
            }
            .navigationTitle("Podcasts")
        }
    }
}

struct TabBarController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let homeView = UIHostingController(rootView: HomeView())
        let musicView = UIHostingController(rootView: MusicView())
        let podcastsView = UIHostingController(rootView: PodcastsView())

        homeView.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        musicView.tabBarItem = UITabBarItem(title: "Music", image: UIImage(systemName: "music.note.list"), tag: 1)
        podcastsView.tabBarItem = UITabBarItem(title: "Podcasts", image: UIImage(systemName: "mic.fill"), tag: 2)

        tabBarController.viewControllers = [homeView, musicView, podcastsView]

        // Apply Default Stronger Transparency & Reduce Transparency Handling
        updateTabBarAppearance(tabBarController)

        return tabBarController
    }

    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {
        updateTabBarAppearance(uiViewController)
    }

    private func updateTabBarAppearance(_ tabBarController: UITabBarController) {
        let isReduceTransparency = UIAccessibility.isReduceTransparencyEnabled
        
        if isReduceTransparency {
            // Solid background when Reduce Transparency is ON
            tabBarController.tabBar.backgroundColor = UIColor.white
        } else {
            // More obvious transparency effect
            tabBarController.tabBar.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)
            tabBarController.tabBar.isTranslucent = true
        }
    }
}
