//
//  ScreenshotOverlayView.swift
//  screenGuard
//
//  Created by Lovice Sunuwar on 03/12/2024.
//

import UIKit

public class ScreenshotOverlayView: UIView {
    
    private var customView: UIView?
    
    public init(frame: CGRect, customView: UIView? = nil) {
        self.customView = customView
        super.init(frame: frame)
        
        // Set the overlay background color with transparency
        backgroundColor = UIColor.black.withAlphaComponent(0.7)

        // If a custom view (e.g., button) is passed, add it to the center of the overlay
        if let customView = customView {
            addSubview(customView)
            
            // Use Auto Layout to center the custom view (button) in the middle of the screen
            customView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                customView.centerXAnchor.constraint(equalTo: centerXAnchor),
                customView.centerYAnchor.constraint(equalTo: centerYAnchor),
                customView.widthAnchor.constraint(equalToConstant: 300),  // Adjust width
                customView.heightAnchor.constraint(equalToConstant: 60)   // Adjust height
            ])
        } else {
            // Default behavior: Show a message if no custom view is passed
            let messageLabel = UILabel()
            messageLabel.text = "Default behaviour."
            messageLabel.textColor = .white
            messageLabel.textAlignment = .center
            addSubview(messageLabel)
            
            // Auto Layout for message label
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
        
        // Enable taps on the overlay view
        isUserInteractionEnabled = true
        
        // Add tap gesture recognizer to dismiss the overlay when tapping outside custom view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideView(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Handle tap gesture to dismiss overlay if tapped outside of custom view
    @objc private func handleTapOutsideView(_ sender: UITapGestureRecognizer) {
        // Get the location of the tap within the overlay view
        let location = sender.location(in: self)
        
        if let customView = customView, !customView.frame.contains(location) {
            // If the tap is outside the custom view, remove the overlay
            self.removeFromSuperview()
        } else if customView == nil {
            // If no custom view is passed, remove the overlay on any tap
            self.removeFromSuperview()
        }
    }
}
