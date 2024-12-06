//
// ScreenshotBlockable.swift
//  ScreenGuard
//
//  Created by Lovice Sunuwar on 06/12/2024.
//


import Foundation

public protocol ScreenshotBlockable {
    var shouldBlockScreenshot: Bool { get }
    var shouldShowCustomOverlay: Bool { get }
}
