# UITabBarController Accessibility Demo

This is a SwiftUI + UIKit demo app that tests accessibility modifications to a `UITabBarController`.

## 📌 Features
- **Reduce transparency**: Automatically adjusts transparency based on the `Reduce Transparency` setting.
- **Increased Contrast**: Updates icon and color visibility when `Increase Contrast` is enabled.
- **Live Accessibility Status**: Displays the current state of accessibility settings on the home screen.
- **Dynamic UI Updates**: Uses `NotificationCenter` to detect and respond to setting changes in real time.

## 📲 How It Works
| Setting               | Behavior |
|-----------------------|----------|
| **Reduce Transparency (OFF)** | Tab bar is semi-transparent (`alpha 0.5`). |
| **Reduce Transparency (ON)**  | Tab bar switches to **solid white** for better readability. |
| **Increase Contrast (ON)**  | Ensures icons and UI elements remain visible and well-defined. |

## 🚀 How to Test
1. **Run the app in Xcode (`Command + R`)**.
2. **Go to iOS Settings > Accessibility > Display & Text Size**.
3. **Toggle "Reduce Transparency" and "Increase Contrast"**.
4. **Return to the app** and see real-time UI updates.

## 🔧 Installation
1. Clone the repo:
   ```bash
   git clone https://github.com/YOUR_GITHUB_USERNAME/UITabBarController-test-app.git
