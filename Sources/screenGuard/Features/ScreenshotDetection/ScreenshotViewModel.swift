//
//  ScreenshotViewModel.swift
//  screenGuard
//
//  Created by Lovice Sunuwar on 03/12/2024.
//

import Foundation

public class ScreenshotViewModel {
    private var screenshotObserver: ScreenshotObserver

    public var onScreenshotDetected: (() -> Void)?

    public init() {
        screenshotObserver = ScreenshotObserver()
        screenshotObserver.onScreenshotDetected = { [weak self] in
            self?.onScreenshotDetected?()
        }
    }

    public func startObserving() {
        screenshotObserver.startObserving()
    }
}
