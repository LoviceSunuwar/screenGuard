
# ScreenGuard Overlay

A custom iOS overlay for detecting screenshots, preventing screenshots, and displaying custom UI elements on top of the screen. This package includes a `ScreenshotOverlayView` that can show custom content (such as alert dialogs, custom views, etc.) in response to screenshot detection. It is easy to integrate and customizable for various use cases.

## Features

- **Screenshot Detection**: Detect when a screenshot is taken on the device.
- **Customizable Overlay**: Show a custom view or alert when a screenshot is detected.
- **Dismissable Overlay**: The overlay can be dismissed by tapping outside of the custom view.
- **Flexible Layout**: Easily place the custom view in the center, bottom, or top of the screen, depending on your needs.

## Screenshot Overlay

![ScreenRecording_12-05-202421-37-54_1-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/b583dc0d-ebca-4cdb-80e8-726482304bef)


## Installation

You can install this package by adding it to your project manually or using Swift Package Manager.

### Manual Installation

1. Download the `ScreenshotOverlayView.swift` and `ScreenshotViewModel.swift` files.
2. Add them to your Xcode project.

### Swift Package Manager

1. Open your Xcode project.
2. Go to `File` -> `Add Packages`.
3. In the search bar, enter the URL of this GitHub repository.
4. Select the package and add it to your project.

## How It Works

The `ScreenshotOverlayView` listens for screenshot events and shows a custom view (or a default alert) when a screenshot is detected. It uses a `ScreenshotViewModel` that listens to screenshot events and calls the appropriate callback when a screenshot is taken.

When the overlay is shown, the custom view is added to the overlay, which can be dismissed by tapping outside of the view. You can customize the content displayed inside the overlay to suit your app's needs.

---

## Step-by-Step Guide to Implement the Package

### 1. Import the Package

First, import the `ScreenGuard` package in the view controller or scene where you want to use the screenshot detection feature.

Text:

```
import ScreenGuard
```

### 2. Set Up Screenshot Detection

In the appropriate class (e.g., a view controller or AppDelegate), initialize the `ScreenshotViewModel` to start observing for screenshot events.

Text:

```
var screenshotViewModel: ScreenshotViewModel!
var dismissableOverlay: ScreenshotOverlayView?

override func viewDidLoad() {
    super.viewDidLoad()

    // Initialize ScreenshotViewModel
    screenshotViewModel = ScreenshotViewModel()

    // Start observing for screenshots
    screenshotViewModel.startObserving()

    // Set up callback to show overlay when a screenshot is detected
    screenshotViewModel.onScreenshotDetected = { [weak self] in
        DispatchQueue.main.async {
            self?.showCustomOverlayView()
        }
    }
}
```

### 3. Create and Display the Overlay

Create a method to show the overlay view with your custom content. You can place the custom view at the top, center, or bottom of the screen, depending on your needs.

Text:

```
func showCustomOverlayView() {
    guard let window = view.window else { return }

    // Create your custom view to be shown inside the overlay
    let customView = UIView()
    customView.backgroundColor = .lightGray
    customView.layer.cornerRadius = 10
    customView.clipsToBounds = true
    customView.frame = CGRect(x: 0, y: window.bounds.height - (window.bounds.height * 0.3), width: window.bounds.width, height: window.bounds.height * 0.3)

    // Add buttons or other UI elements to your custom view
    let buttonWidth = customView.bounds.width * 0.2
    let buttonHeight = customView.bounds.height * 0.6
    let buttonSpacing = customView.bounds.width * 0.05

    for i in 0..<4 {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: CGFloat(i) * (buttonWidth + buttonSpacing) + buttonSpacing,
                              y: (customView.bounds.height - buttonHeight) / 2,
                              width: buttonWidth,
                              height: buttonHeight)
        button.setTitle("Button \(i + 1)", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        customView.addSubview(button)
    }

    // Use ScreenshotOverlayView to manage the overlay and the custom view
    let overlayView = ScreenshotOverlayView(frame: window.bounds, customView: customView)
    window.addSubview(overlayView)

    // Store the overlay view reference
    dismissableOverlay = overlayView
}
```

### 4. Handle Button Actions

You can define actions for buttons or other UI elements inside your custom overlay view.

Text:

```
@objc func buttonTapped(_ sender: UIButton) {
    if let title = sender.titleLabel?.text {
        print("\(title) pressed!")
    }
}
```

### 5. Customize the Overlay Layout

You can customize the layout of the custom view by adjusting the frame of `customView` in the `showCustomOverlayView` method.

To place the custom view in the center:

Text:

```
customView.frame = CGRect(x: (window.bounds.width - customView.bounds.width) / 2,
                          y: (window.bounds.height - customView.bounds.height) / 2,
                          width: customView.bounds.width,
                          height: customView.bounds.height)
```

To place it at the top:

Text:

```
customView.frame = CGRect(x: 0, y: 0, width: window.bounds.width, height: window.bounds.height * 0.3)
```

### 6. Dismiss the Overlay

When the user taps outside the custom view, the overlay and the custom view will be dismissed. The overlay view automatically handles the dismissal when the user taps outside of the custom view.

Optional: Customizing the Dismissal Behavior
You can further customize the dismissal behavior by modifying the `ScreenshotOverlayView`'s `handleTapOutsideView` function, or by adjusting the gesture recognizer behavior to suit your app’s requirements.

---

## Customization

- **Custom View**: You can replace the default alert with any custom view of your choice. This custom view will be added to the overlay and can be customized to your needs (e.g., buttons, labels, etc.).
- **Dismiss Behavior**: The overlay and custom view are removed when the user taps outside the custom view.
- **Positioning**: You can position the custom view at the top, bottom, or center of the screen by adjusting its frame.

---

## License

This package is licensed under the MIT License. See LICENSE for more information.
