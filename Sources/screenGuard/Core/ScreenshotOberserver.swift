//
//  ScreenshotOberserver.swift
//  screenGuard
//
//  Created by Lovice Sunuwar on 03/12/2024.
//

import UIKit

public class ScreenshotObserver {
    private var observer: NSObjectProtocol?

    public init() {}

    public func registerObserver(action: @escaping () -> Void) {
        observer = NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: .main) { _ in
            action()
        }
    }

    public func removeObserver() {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
