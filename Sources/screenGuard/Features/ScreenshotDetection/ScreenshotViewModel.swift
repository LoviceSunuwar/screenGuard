//
//  ScreenshotViewModel.swift
//  screenGuard
//
//  Created by Lovice Sunuwar on 03/12/2024.
//

import Foundation

public class ScreenshotViewModel {
    private var screenshotObserver: ScreenshotObserver?
    private var preventionViewModel: ScreenshotPreventionViewModel?

    public var onScreenshotDetected: (() -> Void)?
    public var onScreenCaptureDetected: (() -> Void)?

    public init() {
        screenshotObserver = ScreenshotObserver()
        preventionViewModel = ScreenshotPreventionViewModel()
    }

    // Start observing for screenshots and screen capture changes
    public func startObserving() {
        screenshotObserver?.registerObserver {
            self.onScreenshotDetected?()
        }
        preventionViewModel?.onScreenCaptureDetected = {
            self.onScreenCaptureDetected?()
        }
        preventionViewModel?.startObserving()
    }

    // Stop observing for screenshots and screen capture changes
    public func stopObserving() {
        screenshotObserver?.removeObserver()
        preventionViewModel?.stopObserving()
    }

    // Dynamically block screenshots for a specific view controller
    public func blockScreenshots(for viewController: UIViewController) {
        preventionViewModel?.blockScreenshots(for: viewController)
    }

    // Dynamically unblock screenshots for a specific view controller
    public func unblockScreenshots(for viewController: UIViewController) {
        preventionViewModel?.unblockScreenshots(for: viewController)
    }
}
