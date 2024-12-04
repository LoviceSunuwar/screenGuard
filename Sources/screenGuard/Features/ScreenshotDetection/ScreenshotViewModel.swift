//
//  ScreenshotViewModel.swift
//  screenGuard
//
//  Created by Lovice Sunuwar on 03/12/2024.
//

import Foundation

public class ScreenshotViewModel {
    private var screenshotObserver: ScreenshotObserver?

    public var onScreenshotDetected: (() -> Void)?

    public init() {
        screenshotObserver = ScreenshotObserver()
    }

    public func startObserving() {
        screenshotObserver?.registerObserver {
            self.onScreenshotDetected?()
        }
    }

    public func stopObserving() {
        screenshotObserver?.removeObserver()
    }
}
