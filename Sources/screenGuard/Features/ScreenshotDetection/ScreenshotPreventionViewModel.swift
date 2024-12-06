//
//  File.swift
//  ScreenGuard
//
//  Created by Lovice Sunuwar on 05/12/2024.
//

import UIKit

public class ScreenshotPreventionViewModel {
    private var screenCaptureObserver: NSObjectProtocol?
    private var blockedViewControllers: Set<UIViewController> = []

    public var onScreenCaptureDetected: (() -> Void)?

    public init() {
        // Register observer for screen capture changes
        screenCaptureObserver = NotificationCenter.default.addObserver(
            forName: UIScreen.capturedDidChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            self?.handleScreenCaptureChange()
        }
    }

    // Start observing for screen captures
    public func startObserving() {
        if UIScreen.main.isCaptured {
            onScreenCaptureDetected?()
        }
    }

    // Stop observing for screen captures
    public func stopObserving() {
        if let observer = screenCaptureObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    // Add a view controller to the block list for screenshots
    public func blockScreenshots(for viewController: UIViewController) {
        blockedViewControllers.insert(viewController)
    }

    // Remove a view controller from the block list
    public func unblockScreenshots(for viewController: UIViewController) {
        blockedViewControllers.remove(viewController)
    }

    // Handle screen capture detection
    private func handleScreenCaptureChange() {
        for viewController in blockedViewControllers {
            if UIScreen.main.isCaptured {
                print("Screenshot or screen capture detected for \(viewController)")
                onScreenCaptureDetected?()
            }
        }
    }
}
