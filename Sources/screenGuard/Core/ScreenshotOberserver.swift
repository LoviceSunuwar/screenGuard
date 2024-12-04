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
            print("Screenshot detected!")  // Debugging line to check if the notification is triggered
            action()
        }
    }

    public func removeObserver() {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
