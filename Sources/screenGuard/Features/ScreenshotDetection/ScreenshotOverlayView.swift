//
//  ScreenshotOverlayView.swift
//  screenGuard
//
//  Created by Lovice Sunuwar on 03/12/2024.
//

import UIKit

public class ScreenshotOverlayView: UIView {
    
    private var customView: UIView?
    
    // Initialize the view with an optional custom view
    public init(frame: CGRect, customView: UIView? = nil) {
        self.customView = customView
        super.init(frame: frame)
        
        // Set background color with transparency for overlay effect
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        // If a custom view is provided, add it to the overlay
        if let customView = customView {
            addSubview(customView)
            
            // Center the custom view in the overlay
            customView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                customView.centerXAnchor.constraint(equalTo: centerXAnchor),
                customView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        } else {
            // Default behavior: Show a message if no custom view is provided
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
        
        // Add gesture recognizer to detect taps outside the custom view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideView(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    // Required for initialization from storyboard (if used)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Handle tap gesture: remove the overlay if tapped outside the custom view
    @objc private func handleTapOutsideView(_ sender: UITapGestureRecognizer) {
        // Determine if the tap occurred outside the custom view
        let location = sender.location(in: self)
        
        if let customView = customView, !customView.frame.contains(location) {
            // Remove the overlay if tapped outside the custom view
            self.removeFromSuperview()
        } else if customView == nil {
            // Remove the overlay if no custom view is present (default behavior)
            self.removeFromSuperview()
        }
    }
}
