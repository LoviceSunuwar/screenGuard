//
//  ScreenshotOverlayView.swift
//  screenGuard
//
//  Created by Lovice Sunuwar on 03/12/2024.
//

import UIKit

public class ScreenshotOverlayView: UIView {

    private var customView: UIView?

    // Init method to accept a custom view
    public init(frame: CGRect, customView: UIView? = nil) {
        self.customView = customView
        super.init(frame: frame)

        backgroundColor = UIColor.black.withAlphaComponent(0.7)

        // Add the custom view or default message
        if let customView = customView {
            addSubview(customView)
            customView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                customView.centerXAnchor.constraint(equalTo: centerXAnchor),
                customView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        } else {
            let messageLabel = UILabel()
            messageLabel.text = "Oops! Screenshot is not allowed."
            messageLabel.textColor = .white
            messageLabel.textAlignment = .center
            addSubview(messageLabel)
            
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }

        // Gesture recognizer to detect taps outside the custom view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideView(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Handles tap outside the custom view to remove the overlay
    @objc private func handleTapOutsideView(_ sender: UITapGestureRecognizer) {
        if let customView = customView {
            let location = sender.location(in: self)
            // Remove overlay if tap is outside custom view
            if !customView.frame.contains(location) {
                self.removeFromSuperview()
            }
        }
    }
}
