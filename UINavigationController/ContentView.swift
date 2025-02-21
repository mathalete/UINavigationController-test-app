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
    @State private var isBoldText: Bool = UIAccessibility.isBoldTextEnabled


    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("UITabController tests")
                        .font(.largeTitle)
                        .padding(.bottom, 10)

                    
                    featureStatus(
                        title: "Reduce Transparency is",
                        value: isReduceTransparency ? "Enabled ✅" : "Disabled ❌"
                    )

                    featureDescription(
                        title: "Reduce transparency",
                        description: "By default, when Reduce Transparency is enabled in iOS Accessibility settings, iOS automatically reduces transparent or blurred UI elements to enhance readability. In this implementation,  a solid background color is defined for the tab bar - white in Light Mode and black in Dark Mode - when Reduce Transparency is enabled. When Reduce Transparency is off, the tab bar has a designed opacity treatment using a subtle semi-transparent effect (alpha 0.5), ensuring a visually polished experience while still adapting to system-wide accessibility settings."
                    )
                    
                    featureStatus(
                        title: "Increase Contrast is",
                        value: isHighContrast ? "Enabled ✅" : "Disabled ❌"
                    )
                    
                    featureDescription(
                        title: "Increase contrast",
                        description: "By default, when Increase Contrast is enabled in iOS Accessibility settings, iOS enhances the visibility of UI elements by boosting contrast between foreground and background colors, making interface elements more distinct and easier to read. In this implementation, instead of relying solely on iOS’s automatic contrast adjustments, we explicitly define the tab bar icon colors to ensure clear visual distinction. The selected tab icon is dynamically colored—#D24712 in Light Mode and #FF7B22 in Dark Mode—while the unselected icons use a consistent system gray (#999999)."
                    )
                    
                    featureStatus(
                                           title: "Bold Text is",
                                           value: isBoldText ? "Enabled ✅" : "Disabled ❌"
                                       )
                    
                    featureDescription(
                        title: "Bold text",
                        description: "By default, when Bold Text is enabled in iOS Accessibility settings, iOS automatically thickens system fonts across the UI to improve legibility, including app labels, buttons, and other text elements. In this implementation, we detect the Bold Text setting and ensure that the UI updates in real time when it is enabled or disabled. The tab bar icons are SF Symbols, which automatically respond to the Bold Text setting by displaying their thicker, high-contrast variants when enabled."
                    )

                    
                    // Placeholder Image
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                    
                    Text("To test, try enabling 'Reduce Transparency', 'Increase Contrast', or 'Bold Text' in iOS Settings to see the changes.")
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

            notificationCenter.addObserver(forName: UIAccessibility.boldTextStatusDidChangeNotification, object: nil, queue: .main) { _ in
                self.isBoldText = UIAccessibility.isBoldTextEnabled
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

        homeView.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        musicView.tabBarItem = UITabBarItem(title: "Music", image: UIImage(systemName: "music.note.list"), selectedImage: UIImage(systemName: "music.note.list"))
        podcastsView.tabBarItem = UITabBarItem(title: "Podcasts", image: UIImage(systemName: "mic"), selectedImage: UIImage(systemName: "mic.fill"))

        tabBarController.viewControllers = [homeView, musicView, podcastsView]

        // Apply correct styling based on accessibility and appearance settings
        updateTabBarAppearance(tabBarController)

        return tabBarController
    }

    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {
        updateTabBarAppearance(uiViewController)
    }

    private func updateTabBarAppearance(_ tabBarController: UITabBarController) {
        let isDarkMode = UITraitCollection.current.userInterfaceStyle == .dark
        let isReduceTransparency = UIAccessibility.isReduceTransparencyEnabled

        // Define colors for selected and unselected icons
        let selectedColor = isDarkMode ? UIColor(red: 1.0, green: 0.48, blue: 0.13, alpha: 1.0) : UIColor(red: 0.82, green: 0.28, blue: 0.07, alpha: 1.0) // #FF7B22 (Dark) / #D24712 (Light)
        let unselectedColor = UIColor.systemGray // Equivalent to #999999

        // Apply colors to tab bar icons
        tabBarController.tabBar.tintColor = selectedColor // Selected tab icon color
        tabBarController.tabBar.unselectedItemTintColor = unselectedColor // Unselected icon color

        // Ensure a solid block of color when Reduce Transparency is enabled
        if isReduceTransparency {
            tabBarController.tabBar.backgroundColor = isDarkMode ? UIColor.black : UIColor.white
            tabBarController.tabBar.isTranslucent = false
        } else {
            // Use dynamic system background (transparent effect in normal mode)
            tabBarController.tabBar.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)
            tabBarController.tabBar.isTranslucent = true
        }
    }
}
